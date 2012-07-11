module BoardsHelper
  def is_weekend(date)
    # %u - Day of the week (Monday is 1, 1..7) 
    if date.strftime("%u").to_i == 6 || date.strftime("%u").to_i == 7
      true
    else
      false
    end
  end
end