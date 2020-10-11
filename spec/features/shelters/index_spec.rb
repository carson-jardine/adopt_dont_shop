require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit /shelters' do
    before :each do
      @shelter_1 = Shelter.create(
                name:    "The Feline Fix",
                address:  "6075 Parkway Drive",
                city:     "Denver",
                state:    "CO",
                zip:      "80022")
      @shelter_2 = Shelter.create(
                name:    "The Dumb Friends League",
                address:  "2080 S Quebec Street",
                city:     "Denver",
                state:    "CO",
                zip:      "80231")
    end

    it "The visitor sees the name of each shelter in the system" do
      visit "/shelters"

      expect(page).to have_content("#{@shelter_1.name}")
      expect(page).to have_content("#{@shelter_2.name}")
    end

    it "The visitor sees an edit link next to each shelter" do
      visit "/shelters"

      expect(page).to have_link("Edit #{@shelter_1.name}")
      expect(page).to have_link("Edit #{@shelter_2.name}")

      click_link("Edit #{@shelter_1.name}")
      expect(current_path).to eq("/shelters/#{@shelter_1.id}/edit")
    end
  end
end
