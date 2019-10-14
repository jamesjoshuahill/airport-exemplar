require 'plane'

RSpec.describe Plane do
  let(:airport) { double(:airport, :clear_to_land? => true) }

  context "when it is flying" do
    it { is_expected.to be_flying }

    it "cannot take off" do
      expect { subject.take_off }.to raise_error "already flying"
    end

    it "checks it is clear to land" do
      subject.land(airport)

      expect(airport).to have_received(:clear_to_land?)
    end

    it "rejects instruction to land if not safe" do
      allow(airport).to receive(:clear_to_land?).and_return(false)

      expect { subject.land(airport) }.to raise_error "not safe to land"
    end
  end

  context "when landed at an airport" do
    before do
      subject.land(airport)
    end

    it { is_expected.not_to be_flying }

    it "rejects instructions to land" do
      expect { subject.land(airport) }.to raise_error "already landed"
    end

    it "checks it is clear to take off" do
      allow(airport).to receive(:clear_for_take_off?).and_return(true)

      subject.take_off

      expect(airport).to have_received(:clear_for_take_off?)
    end

    it "rejects instruction to take off if not safe" do
      allow(airport).to receive(:clear_for_take_off?).and_return(false)

      expect { subject.take_off }.to raise_error "not safe for take off"
    end
  end
end
