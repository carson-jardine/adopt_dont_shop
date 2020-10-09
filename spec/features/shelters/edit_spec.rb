require 'rails_helper'

describe 'As a visitor' do
  shelter_1 = Shelter.create(name:    "The Feline Fix",
                            address:  "6075 Parkway Drive",
                            city:     "Denver",
                            state:    "CO",
                            zip:      "80022")

  describe 'When I visit /shelters/:id' do
    it "User can navigate to Update Shelter page" do
      visit "/shelters/#{shelter_1.id}"
      click_on "Update Shelter"

      expect(page).to have_content("Edit Shelter Info:")
      expect(page).to have_button("Update Shelter")
    end
  end
end
