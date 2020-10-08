require 'rails_helper'

describe 'As a visitor' do 
  describe 'When I visit /shelters' do
    it "the visitor sees the name of each shetler in the system" do
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
      visit "/shelters"

      expect(page).to have_content(shelter_1.name)
      expect(page).to have_content(shelter_2.name)
    end

  end
end
