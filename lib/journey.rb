class Journey
  attr_reader :entry, :exit

  def initialize(entry, _exit)
    @entry = entry
    @exit = _exit
  end
end
