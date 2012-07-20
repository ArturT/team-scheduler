class DefaultDay
  attr_reader :date, :hours

  def initialize(date, hours)
    @date = date
    @hours = hours
  end

  def id
    -1
  end
end