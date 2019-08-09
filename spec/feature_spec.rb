RSpec.describe "Air traffic control" do
  it "can land and take off a number of planes at an airport" do
    plane1 = Plane.new
    plane2 = Plane.new
    plane3 = Plane.new
    weather = instance_double("Weather")
    allow(weather).to receive(:outlook).and_return(:sunny)
    airport = Airport.new(weather: weather)

    airport.land(plane1)
    airport.land(plane2)
    airport.take_off(plane2)
    airport.land(plane3)
    airport.take_off(plane1)

    expect(plane1).to be_flying
    expect(plane2).to be_flying
    expect(airport.planes).to contain_exactly(plane3)
  end
end
