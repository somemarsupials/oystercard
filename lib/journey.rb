class Journey
  attr_reader :entry_station, :exit_station

  def initialize(entry_station, exit_station)
    @entry = entry_station
    @exit = exit_station
  end
end
