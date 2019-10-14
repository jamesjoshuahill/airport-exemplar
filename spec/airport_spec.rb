require 'airport'

RSpec.describe Airport do
  subject { Airport.new(weather: weather) }
  let(:weather) { double(:weather) }
  let(:plane) { double(:plane) }

  it "knows if a plane is registered" do
    expect(subject.registered?(plane)).to be_falsey
  end

  it "can register a plane" do
    subject.register(plane)

    expect(subject.registered?(plane)).to be_truthy
  end

  it "cannot register a plane that has already registered" do
    subject.register(plane)

    expect { subject.register(plane) }.to raise_error "already registered"
  end

  it "can register 8 planes" do
    8.times { subject.register(double(:plane)) }

    expect { subject.register(double(:plane)) }.to raise_error "airport full"
  end

  it "can deregister a registered plane" do
    plane = double(:plane)
    subject.register(plane)

    subject.deregister(plane)

    expect(subject.registered?(plane)).to be_falsey
  end

  it "cannot deregister a plane that has not registered" do
    expect { subject.deregister(double(:plane)) }.to raise_error "not registered"
  end

  context "when full" do
    subject { Airport.new(weather: weather, capacity: 0) }

    it { is_expected.not_to be_clear_to_land }
  end

  context "when sunny" do
    before do
      allow(weather).to receive(:outlook).and_return(:sunny)
    end

    it { is_expected.to be_clear_to_land }
    it { is_expected.to be_clear_for_take_off }
  end

  context "when stormy" do
    before do
      allow(weather).to receive(:outlook).and_return(:stormy)
    end

    it { is_expected.not_to be_clear_to_land }
    it { is_expected.not_to be_clear_for_take_off }
  end
end
