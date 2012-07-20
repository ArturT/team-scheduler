# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :non_default_day do
    date "2012-01-01"
    hours 8
    schedule
  end
end
