require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit /applications/id' do
    before :each do

    @shelter_1 = Shelter.create!({
        name:    "The Feline Fix",
        address:  "6075 Parkway Drive",
        city:     "Denver",
        state:    "CO",
        zip:      "80022"})
    @shelter_2 = Shelter.create!({
          name:    "The Dumb Friends League",
          address:  "2080 S Quebec Street",
          city:     "Denver",
          state:    "CO",
          zip:      "80231"})
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

    @application = Application.create!({
      user_id: "#{@user_1.id}",
      name: "#{@user_1.name}",
      application_status: 'In Progress'
      })

    end
    it "The visitor can see the application details" do
      visit "/applications/#{@application.id}"

      expect(page).to have_content("#{@user_1.name}")
      expect(page).to have_content("#{@user_1.address}")
      expect(page).to have_content("#{@user_1.city}")
      expect(page).to have_content("#{@user_1.state}")
      expect(page).to have_content("#{@user_1.zip}")

      expect(page).to have_content("#{@application.description}")

      expect(page).to have_content("#{@application.application_status}")
    end
    it "Can search for a pet" do
      visit "/applications/#{@application.id}"

      expect(page).to have_content("Add a Pet to this Application")
      fill_in "search", with: "#{@pet_1.name}"
      click_button "Submit"
      expect(current_path).to eq("/applications/#{@application.id}")

      expect(page).to have_content("#{@pet_1.name}")
    end

    it "Shows adopt pet button" do

      visit "/applications/#{@application.id}"

      fill_in "search", with: "#{@pet_1.name}"
      click_button "Submit"

      expect(page).to have_button("Adopt this Pet")
      click_button "Adopt this Pet"

      expect(current_path).to eq("/applications/#{@application.id}")

      within "#pet-of-interest-#{@pet_1.id}" do
        expect(page).to have_content("#{@pet_1.name}")
        expect(page).to have_link("#{@pet_1.name}")
      end
    end
    it 'User can submit application once they have added pets' do

      visit "/applications/#{@application.id}"
      fill_in 'search', with: "#{@pet_1.name}"
      click_button 'Submit'
      click_button "Adopt this Pet"
      expect(page).to have_content('Submit My Application')
      fill_in 'Description', with: 'I will take care of her'
      click_button 'Submit This Application'
      expect(current_path).to eq("/applications/#{@application.id}")
      expect(page).to have_content('Pending')
      expect(page).to have_content("#{@pet_1.name}")
      expect(page).to_not have_content('Add a Pet to this Application')
    end
    it "If user has not added pets to their application, they do not see a section to submit their application" do
      visit "/applications/#{@application.id}"
      fill_in 'search', with: "#{@pet_1.name}"
      click_button 'Submit'
      expect(page).to_not have_content('Submit This Application')
    end

    it "A search will still match when input is partial match" do
      visit "/applications/#{@application.id}"
      fill_in 'search', with: "Lou"
      click_button 'Submit'

      expect(page).to have_content("Louis")
    end

    it "show flash message if no description" do
      visit "/applications/#{@application.id}"
      fill_in 'search', with: "#{@pet_1.name}"
      click_button 'Submit'
      click_button "Adopt this Pet"
      expect(page).to have_content('Submit My Application')
      click_button 'Submit This Application'
      expect(page).to have_content('Fill Out Description')
    end
  end
end
