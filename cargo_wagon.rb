class CargoWagon < Wagon
 
  TOTAL_VOLUME = @volume
  def initialize(number, volume = 80)
    @type = :cargo 
    @volume = volume
    super(number)
  end

  def body_volume(volume)
    @volume = TOTAL_VOLUME - volume
  end

  def ccupied_volume
    TOTAL_VOLUME - @volume
  end

  def available_volume
    @volume
  end
end
