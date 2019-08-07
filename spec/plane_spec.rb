require 'plane'

RSpec.describe Plane do
  it { is_expected.to be_flying }

  it "can land" do
    subject.land

    expect(subject).not_to be_flying
  end

  it "cannot take off" do
    expect { subject.take_off }.to raise_error "already flying"
  end

  context "when landed" do
    before do
      subject.land
    end

    it { is_expected.not_to be_flying }

    it "can take off" do
      subject.take_off

      expect(subject).to be_flying
    end

    it "cannot land" do
      expect { subject.land }.to raise_error "already landed"
    end
  end
end
