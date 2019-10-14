class Airport
  DEFAULT_CAPACITY = 8

  def initialize(weather: Weather.new, capacity: DEFAULT_CAPACITY)
    @weather = weather
    @capacity = capacity
    @planes = []
  end

  def clear_to_land?
    !full? && !stormy?
  end

  def clear_for_take_off?
    !stormy?
  end

  def register(plane)
    raise "already registered" if registered?(plane)
    raise "airport full" if full?

    @planes.push(plane)
  end

  def deregister(plane)
    raise "not registered" if !registered?(plane)

    @planes.delete(plane)
  end

  def registered?(plane)
    @planes.include?(plane)
  end

  private

  def stormy?
    @weather.outlook == :stormy
  end

  def full?
    @planes.length == @capacity
  end
end
