# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :schedule do |f|
    f.developer_id 1
    f.project_id 1
    f.start_date "2012-07-06"
    f.end_date "2012-07-07"
  end
end
