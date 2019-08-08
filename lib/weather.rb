class Weather
  OUTLOOKS = [:sunny, :stormy]

  def outlook
    OUTLOOKS.sample
  end
end
