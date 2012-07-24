# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:hex_color) { "#{generate_hex_color}" }

  factory :project do
    name 'ProjectName'
    color { FactoryGirl.generate(:hex_color) }
    company
  end
end

def generate_hex_color
  '#' + ('%06x' % (rand * 0xffffff))
end