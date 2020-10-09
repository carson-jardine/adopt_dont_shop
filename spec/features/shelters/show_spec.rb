require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit /shelters/:id' do
    before :each do
      #let block lazy load rspec
      @shelter_1 = Shelter.create(name:    "The Feline Fix",
        address:  "6075 Parkway Drive",
        city:     "Denver",
        state:    "CO",
        zip:      "80022")
      @shelter_2 = Shelter.create(name:    "The Dumb Friends League",
          address:  "2080 S Quebec Street",
          city:     "Denver",
          state:    "CO",
          zip:      "80231")
    end
    it "the visitor sees the shelter with that id and its name, address, city, state, and zip" do
      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_content("Address: #{@shelter_1.address}")
      expect(page).to have_content("#{@shelter_1.city}")
      expect(page).to have_content("#{@shelter_1.state}")
      expect(page).to have_content("#{@shelter_1.zip}")
      # could be broken into different tests
      visit "/shelters/#{@shelter_2.id}"

      expect(page).to have_content("Address: #{@shelter_2.address}")
      expect(page).to have_content("#{@shelter_2.city}")
      expect(page).to have_content("#{@shelter_2.state}")
      expect(page).to have_content("#{@shelter_2.zip}")
    end
  end
end
