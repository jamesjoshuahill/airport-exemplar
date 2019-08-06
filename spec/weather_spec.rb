require 'weather'

RSpec.describe Weather do
  it "is stormy sometimes" do
    expect(subject.stormy?).to be(true).or be(false)
  end
end
