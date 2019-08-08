require 'weather'

RSpec.describe Weather do
  it "can be sunny" do
    srand(0)

    expect(subject.outlook).to eq(:sunny)
  end

  it "can be stormy" do
    srand(1)

    expect(subject.outlook).to eq(:stormy)
  end
end
