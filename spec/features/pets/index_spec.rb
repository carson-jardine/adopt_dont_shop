require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit /pets' do
    before :each do
      @shelter_1 = Shelter.create(
          name:     "The Dumb Friends League",
          address:  "2080 S Quebec Street",
          city:     "Denver",
          state:    "CO",
          zip:      "80231")
      @pet_1 = Pet.create(
          image: "http://cdn.akc.org/content/hero/cute_puppies_hero.jpg",
          name:  "Louis",
          approximate_age: 2,
          sex: "Male",
          shelter_id: "#{@shelter_1.id}")
      @pet_2 = Pet.create(
          image: "http://cdn.akc.org/content/article-body-image/wirehaired_pointing_griffon_cute_puppies.jpg",
          name:  "Charlie",
          approximate_age: 5,
          sex: "Male",
          shelter_id: "#{@shelter_1.id}")
      @pet_3 = Pet.create(
          image: "http://cdn.akc.org/content/article-body-image/irish_setter_cute_puppies.jpg",
          name:  "Colby",
          approximate_age: 12,
          sex: "Male",
          shelter_id: "#{@shelter_1.id}")
    end

    it "The visitor sees the details about each pet in system" do

      visit "/pets"

      expect(page).to have_xpath("//img[contains(@src, '#{@pet_1.image}')]")
      expect(page).to have_content("#{@pet_1.name}")
      expect(page).to have_content("#{@pet_1.approximate_age}")
      expect(page).to have_content("#{@pet_1.sex}")
      expect(page).to have_content("#{@pet_1.shelter.name}")
    end

    it "The visitor sees an edit link next to each pet" do
      visit "/pets"

      expect(page).to have_link("Edit: #{@pet_1.name}")
      expect(page).to have_link("Edit: #{@pet_2.name}")

      click_link("Edit: #{@pet_1.name}")
      expect(current_path).to eq("/pets/#{@pet_1.id}/edit")
    end

    it "The visitor sees a delete link next to each shelter" do
      visit "/pets"

      expect(page).to have_link("Delete: #{@pet_1.name}")
      expect(page).to have_link("Delete: #{@pet_2.name}")

      click_link("Delete: #{@pet_3.name}")
      expect(current_path).to eq("/pets")

      expect(page).to_not have_content("Meet #{@pet_3.name}!")
    end
  end
end
