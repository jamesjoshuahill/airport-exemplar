class Airport
  DEFAULT_CAPACITY = 8

  def initialize(weather: Weather.new, capacity: DEFAULT_CAPACITY)
    @no_of_planes = 0
    @weather = weather
    @capacity = capacity
  end

  def clear_to_land?
    return false if full? || stormy?

    @no_of_planes += 1
  end

  def clear_for_take_off?
    return false if stormy?

    @no_of_planes -= 1
  end

  private

  def stormy?
    @weather.outlook == :stormy
  end

  def full?
    @no_of_planes == @capacity
  end
end
