class Plane
  def initialize
    @flying = true
  end

  def flying?
    @flying
  end

  def land
    raise "already landed" unless flying?
    @flying = false
  end

  def take_off
    raise "already flying" if flying?
    @flying = true
  end
end
