# See http://www.perfectline.ee/blog/building-ruby-on-rails-3-custom-validators
# 0 = off day or sick day
# 2 = 1/4 day
# 4 = 1/2 day
# 6 = 3/4 day
# 8 = full day
class WorkingHoursScopeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if not value.nil?
      unless (0..8).step(2).include?(value)
        record.errors.add(attribute, "must be in scope 0, 2, 4, 6, 8.")
      end
    end
  end
end