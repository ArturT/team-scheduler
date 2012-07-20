# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :non_default_day do
    date Date.today
    hours 4
    schedule
  end
end
