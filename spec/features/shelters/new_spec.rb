require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit /shelter' do
    it "User can navigate to New Shelter page" do
      visit "/shelters"
      click_on "New Shelter"

      expect(page).to have_content("Enter a New Shelter:")
      expect(page).to have_button("Create Shelter")
    end
  end

  describe 'When I visit /shelter/new' do
    it "User can fill out a form" do
      visit "/shelters/new"

      fill_in "shelter[name]",    with: "The Feline Fix"
      fill_in "shelter[address]", with: "6075 Parkway Drive"
      fill_in "shelter[city]",    with: "Denver"
      fill_in "shelter[state]",    with: "CO"
      fill_in "shelter[zip]",    with: "80022"
      click_button "Create Shelter"

      expect(page).to have_content("The Feline Fix")
    end

  end
end
