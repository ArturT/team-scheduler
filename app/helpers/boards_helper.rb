module BoardsHelper
  def weekend?(date)
    # %u - Day of the week (Monday is 1, 1..7)
    if date.strftime("%u").to_i == 6 || date.strftime("%u").to_i == 7
      true
    else
      false
    end
  end

  def today?(date)
    date == Date.today
  end

  def color_column(date)
    if weekend?(date)
      ' class=weekend'
    elsif today?(date)
      ' class=today'
    else
      ''
    end
  end
end