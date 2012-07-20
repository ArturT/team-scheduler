# See http://www.perfectline.ee/blog/building-ruby-on-rails-3-custom-validators
class WorkingHoursScopeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if not value.nil?
      unless (0..8).step(2).include?(value)
       record.errors.add(attribute, "must be in scope 0, 2, 4, 6, 8.")
      end
    end
  end
end