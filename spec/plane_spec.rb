require 'plane'

RSpec.describe Plane do
  let(:airport) { double(:airport) }

  before do
    allow(airport).to receive(:clear_to_land?).and_return(true)
    allow(airport).to receive(:clear_for_take_off?).and_return(true)
    allow(airport).to receive(:register)
    allow(airport).to receive(:deregister)
  end

  context "when it is flying" do
    it { is_expected.to be_flying }

    it "cannot take off" do
      expect { subject.take_off }.to raise_error "already flying"
    end
  end

  context "when landing" do
    it "checks it is clear to land" do
      subject.land(airport)

      expect(airport).to have_received(:clear_to_land?)
    end

    it "registers at the airport" do
      subject.land(airport)

      expect(airport).to have_received(:register).with(subject)
    end

    it "fails if not clear to land" do
      allow(airport).to receive(:clear_to_land?).and_return(false)

      expect { subject.land(airport) }.to raise_error "not clear to land"
    end
  end

  context "when landed at an airport" do
    before { subject.land(airport) }

    it { is_expected.not_to be_flying }

    it "rejects instructions to land" do
      expect { subject.land(airport) }.to raise_error "already landed"
    end
  end

  context "when taking off from an airport" do
    before { subject.land(airport) }

    it "checks it is clear to take off" do
      subject.take_off

      expect(airport).to have_received(:clear_for_take_off?)
    end

    it "deregisters from the airport" do
      subject.take_off

      expect(airport).to have_received(:deregister).with(subject)
    end

    it "fails if not clear for take off" do
      allow(airport).to receive(:clear_for_take_off?).and_return(false)

      expect { subject.take_off }.to raise_error "not clear for take off"
    end
  end
end
