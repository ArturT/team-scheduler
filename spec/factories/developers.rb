# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :developer do
    name 'DevName'
    role 'DevRole'
    company
  end
end
