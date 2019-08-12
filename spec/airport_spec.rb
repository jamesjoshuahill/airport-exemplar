require 'airport'

RSpec.describe Airport do
  let(:subject) { Airport.new(weather: weather) }
  let(:weather) { double("Weather") }
  let(:plane) { double("Plane") }

  before do
    allow(weather).to receive(:outlook).and_return(:sunny)
  end

  it { is_expected.to be_clear_to_land }
  it { is_expected.to be_clear_for_take_off }

  context "when it is stormy" do
    before do
      allow(weather).to receive(:outlook).and_return(:stormy)
    end

    it { is_expected.not_to be_clear_to_land }
    it { is_expected.not_to be_clear_for_take_off }
  end

  context "when the airport is full" do
    let(:subject) { Airport.new(weather: weather, capacity: 0) }

    it { is_expected.not_to be_clear_to_land }
  end
end
