

class Station
  attr_reader :name, :zone

  STATIONS = {
    Waterloo: 1,
    Euston: 2,
    Goodge_Street: 3
  }

  def initialize(name)
    @name = name
    @zone = STATIONS[name]
  end
end
