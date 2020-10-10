require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit /shelters/:id' do
    it "The visitor can delete a shelter" do
      @shelter_1 = Shelter.create(name:     "Denver Animal Shelter",
                                  address:  "1241 W Bayaud Avenue",
                                  city:     "Denver",
                                  state:    "CO",
                                  zip:      "80223")

      visit "/shelters/#{@shelter_1.id}"
      click_on "Delete Shelter"

      expect(page).to_not have_content("Denver Animal Shelter")
    end
  end
end
