require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit /shelters/:id' do
    it "the visitor sees the shelter with that id and its name, address, city, state, and zip" do
      shelter_1 = Shelter.create(name:    "The Feline Fix",
                                address:  "6075 Parkway Drive",
                                city:     "Denver",
                                state:    "CO",
                                zip:      "80022")
      shelter_2 = Shelter.create(name:    "The Dumb Friends League",
                                address:  "2080 S Quebec Street",
                                city:     "Denver",
                                state:    "CO",
                                zip:      "80231")
      visit "/shelters/#{shelter_1.id}"

      expect(page).to have_content("Address: #{shelter_1.address}")
      expect(page).to have_content("City: #{shelter_1.city}")
      expect(page).to have_content("State: #{shelter_1.state}")
      expect(page).to have_content("Zip: #{shelter_1.zip}")

      visit "/shelters/#{shelter_2.id}"

      expect(page).to have_content("Address: #{shelter_2.address}")
      expect(page).to have_content("City: #{shelter_2.city}")
      expect(page).to have_content("State: #{shelter_2.state}")
      expect(page).to have_content("Zip: #{shelter_2.zip}")
    end
  end
end 