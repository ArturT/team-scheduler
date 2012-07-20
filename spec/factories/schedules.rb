# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :schedule do
    start_date Date.today.beginning_of_month
    end_date Date.today.end_of_month
    default_hours 8
    developer
    project
  end
end
