class Plane
  def flying?
    @airport.nil?
  end

  def land(airport)
    raise "already landed" unless flying?
    raise "not safe to land" unless airport.clear_to_land?

    @airport = airport
  end

  def take_off
    raise "already flying" if flying?
    raise "not safe for take off" unless @airport.clear_for_take_off?

    @airport = nil
  end
end
