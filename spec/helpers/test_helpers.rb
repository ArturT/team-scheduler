require 'capybara/rails'

class TestHelpers
  # @param id string id of the dropdown list
  # @param number integer element in the list
  def self.select_option(id, number)
    option = Capybara::find(:xpath, "//*[@id='#{id}']/option[#{number}]").text
    Capybara::select(option, :from => id)
  end
end