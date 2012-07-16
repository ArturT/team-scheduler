# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    name "ProjectName"
    color "#000000"
    company_id 1
  end
end
