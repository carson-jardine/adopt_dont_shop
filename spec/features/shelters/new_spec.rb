require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit /shelter' do
    it "user can navigate to New Shelter page" do
      visit "/shelters"
      click_on "New Shelter"
      expect(page).to have_content("Enter a New Shelter:")
      expect(page).to have_button("Create Shelter")
    end
  end

  describe 'When I visit /shelter/new' do
    it "user can fill out a form" do
      visit "/shelters/new"

      fill_in "shelter[name]",    with: "The Feline Fix"
      fill_in "shelter[address]", with: "6075 Parkway Drive"
      fill_in "shelter[name]",    with: "Denver"
      fill_in "shelter[name]",    with: "CO"
      fill_in "shelter[name]",    with: "80022"
      click_button "Create Shelter"

      expect(page).to have_content("The Feline Fix")
    end

  end
end

# User Story 4, Shelter Creation
#
# As a visitor
# When I visit the Shelter Index page
# Then I see a link to create a new Shelter, "New Shelter"
# When I click this link
# Then I am taken to '/shelters/new' where I  see a form for a new shelter
## ^^^^^ COMPLETED

##WHERE YOU LEFT OFF
# When I fill out the form with a new shelter's:
# - name
# - address
# - city
# - state
# - zip
# And I click the button "Create Shelter" to submit the form
# Then a `POST` request is sent to '/shelters',
# a new shelter is created,
# and I am redirected to the Shelter Index page where I see the new Shelter listed.
