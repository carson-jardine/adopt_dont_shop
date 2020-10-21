require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit /applications/new' do
    before :each do
      @shelter_1 = Shelter.create!({
        name:    "The Feline Fix",
        address:  "6075 Parkway Drive",
        city:     "Denver",
        state:    "CO",
        zip:      "80022"})

      @user_1 = User.create!(
        name:     "Mike Dao",
        address:  "123 Taylor Swift Ave",
        city:     "Denver",
        state:    "CO",
        zip:      "80213")

      @pet_1 = Pet.create!(
        image: "http://cdn.akc.org/content/hero/cute_puppies_hero.jpg",
        name:  "Louis",
        approximate_age: 2,
        sex: "Male",
        shelter_id: "#{@shelter_1.id}")
      @pet_2 = Pet.create!(
        image: "http://cdn.akc.org/content/article-body-image/wirehaired_pointing_griffon_cute_puppies.jpg",
        name:  "Charlie",
        approximate_age: 5,
        sex: "Male",
        shelter_id: "#{@shelter_1.id}")
    end
    it "The visitor can fill out an application form" do

      visit "/applications/new"
      fill_in "applicant_name", with: "#{@user_1.name}"


      click_button "Submit Application"

      application = Application.last
      expect(current_path).to eq("/applications/#{application.id}")
    end
    it "The visitor can't submit an application form if user name doesn't exist" do

      visit "/applications/new"
      fill_in "applicant_name", with: "Mike Doo"

      click_button "Submit Application"
      application = Application.last

      expect(page).to have_content("User does not exist. Please enter a valid user name")
    end
  end
end
