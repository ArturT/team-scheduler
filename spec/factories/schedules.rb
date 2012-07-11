# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :schedule do
    developer_id 1
    project_id 1
    start_date "2012-07-06"
    end_date "2012-07-07"
  end
end
