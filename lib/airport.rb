class Airport
  DEFAULT_CAPACITY = 8

  attr_reader :planes
  attr_reader :capacity

  def initialize(weather, capacity = DEFAULT_CAPACITY)
    @planes = []
    @weather = weather
    @capacity = capacity
  end

  def land(plane)
    raise "plane already landed" if planes.include?(plane)
    raise "airport full" if full?
    raise "not safe to land" if stormy?

    planes.push(plane)
    plane.land
  end

  def take_off(plane)
    raise "plane not registered" unless planes.include?(plane)
    raise "not safe to take off" if stormy?

    planes.delete_if { |p| p == plane }
    plane.take_off
  end

  private

  def stormy?
    @weather.stormy?
  end

  def full?
    planes.length == capacity
  end
end
