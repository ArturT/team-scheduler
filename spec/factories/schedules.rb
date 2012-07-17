# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :schedule do
    start_date "2012-07-06"
    end_date "2012-07-07"
    developer
    project
  end
end
