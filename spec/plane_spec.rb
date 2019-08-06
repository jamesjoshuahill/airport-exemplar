require 'plane'

RSpec.describe Plane do
  it { is_expected.to be_flying }

  it "can land" do
    subject.land

    expect(subject).not_to be_flying
  end

  it "can take off" do
    subject.land

    subject.take_off

    expect(subject).to be_flying
  end
end
