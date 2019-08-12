RSpec.describe "Air traffic control" do
  it "can land and take off a number of planes at an airport" do
    plane1 = Plane.new
    plane2 = Plane.new
    weather = double("Weather")
    allow(weather).to receive(:outlook).and_return(:sunny)
    airport = Airport.new(weather: weather)

    plane1.land(airport)
    plane2.land(airport)
    plane2.take_off
    plane1.take_off

    expect(plane1).to be_flying
    expect(plane2).to be_flying
  end
end
