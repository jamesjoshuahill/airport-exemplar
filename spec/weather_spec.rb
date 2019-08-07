require 'weather'

RSpec.describe Weather do
  it "is stormy about a third of the time" do
    results = Array.new(1000) { subject.stormy? }

    ratio = results.count(true).fdiv(results.length)
    expect(ratio).to be_within(0.1).of(0.3)
  end
end
