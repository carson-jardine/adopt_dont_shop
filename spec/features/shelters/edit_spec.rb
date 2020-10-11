require 'rails_helper'

describe 'As a visitor' do
  before :each do
    @shelter_1 = Shelter.create(
              name:    "The Feline Fix",
              address:  "6075 Parkway Drive",
              city:     "Denver",
              state:    "CO",
              zip:      "80022")
  end

  describe 'When I visit /shelters/:id' do
    it "User can navigate to Update Shelter page" do

      visit "/shelters/#{@shelter_1.id}"
      click_on "Update Shelter"

      expect(page).to have_content("Edit #{@shelter_1.name} Info:")
      expect(page).to have_button("Submit")
    end
  end

  describe "When I visit shelters/:id/edit" do
    it "User can fill in form to update shelter" do

      visit "/shelters/#{@shelter_1.id}/edit"

      fill_in "shelter[name]", with: "The Dumb Friends League"
      fill_in "shelter[address]", with: "2080 S Quebec Street"
      fill_in "shelter[city]", with: "Denver"
      fill_in "shelter[state]", with: "CO"
      fill_in "shelter[zip]", with: "80231"
      click_on "Submit"

      expect(page).to have_content("The Dumb Friends League")
    end
  end
end
