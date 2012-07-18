# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :day_type do
    date "2012-01-01"
    type 8
    schedule_id 1
  end
end
