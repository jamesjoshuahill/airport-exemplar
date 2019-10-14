require 'airport'

RSpec.describe Airport do
  subject { Airport.new(weather: weather) }
  let(:weather) { double(:weather) }
  let(:plane) { double(:plane) }

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

  context "when full" do
    subject { Airport.new(weather: weather, capacity: 0) }

    it { is_expected.not_to be_clear_to_land }
  end
end
