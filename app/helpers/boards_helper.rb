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

  # @param fraction:string | 1, 1/4, 1/2, 3/4. It must be a fraction. Can't be a float.
  # @param color:string | hex color like #000fff 
  # @param size:integer [Default=28] | size of the chart in px
  # How to use: <%= pie_chart('1/2', "#cfcfcf") %>
  def pie_chart(fraction, color, size = 20)
    raw '<span class="pie" data-colour="' + color + '" data-diameter="' + size.to_s + '">' + fraction.to_s + '</span>'
  end

  def hours_to_fraction(hours)
    hours.to_s + '/8'
  end

  def working_hours(non_default_days, date, schedule)
    if date >= schedule.start_date and date <= schedule.end_date
      non_default_days.each do |ndd|
        if ndd.schedule_id == schedule.id and ndd.date == date
          return ndd
        end
      end
      DefaultDay.new(date, schedule.default_hours)
    end
  end
end