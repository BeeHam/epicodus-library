require('spec_helper')
require('capybara/rspec')
require('./app')

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adding a new reader', {:type => :feature}) do
  it('allows a user to add a new reader') do
  visit('/')
  click_link('View All Readers')
  fill_in('name', :with => 'Bill')
  click_button('Add Reader')
  expect(page).to have_content('Bill')
  end


end
