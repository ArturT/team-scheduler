# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :schedule do
    start_date "2012-01-01"
    end_date "2012-01-31"
    developer
    project
  end
end
