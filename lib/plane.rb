class Plane
  def flying?
    @airport.nil?
  end

  def land(airport)
    raise "already landed" unless flying?
    raise "not clear to land" unless airport.clear_to_land?

    airport.register(self)
    @airport = airport
  end

  def take_off
    raise "already flying" if flying?
    raise "not clear for take off" unless @airport.clear_for_take_off?

    @airport.deregister(self)
    @airport = nil
  end
end
