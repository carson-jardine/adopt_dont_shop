require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit /admin/applications/:id' do
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
    @user_2 = User.create!(
        name:     "Ace Ventura",
        address:  "323 Banana Ave",
        city:     "Denver",
        state:    "CO",
        zip:      "80213")
    @user_3 = User.create!(
        name:     "Joe Schmoe",
        address:  "4545 Apple Lane",
        city:     "Denver",
        state:    "CO",
        zip:      "80216")

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
    @pet_3 = Pet.create!(
      image: "http://cdn.akc.org/content/article-body-image/wirehaired_pointing_griffon_cute_puppies.jpg",
      name:  "Carrot",
      approximate_age: 5,
      sex: "Male",
      shelter_id: "#{@shelter_1.id}")

    @application_1 = Application.create!({
      user_id: "#{@user_1.id}",
      name: "#{@user_1.name}",
      application_status: 'Pending',
      description: 'testtest'
      })
    @application_2 = Application.create!({
      user_id: "#{@user_2.id}",
      name: "#{@user_2.name}",
      application_status: 'Pending'
      })
    @application_3 = Application.create!({
      user_id: "#{@user_3.id}",
      name: "#{@user_3.name}",
      application_status: 'Approved'
      })

    PetApplication.create!({pet_id: @pet_1.id, application_id: @application_2.id})
    PetApplication.create!({pet_id: @pet_2.id, application_id: @application_2.id})
    PetApplication.create!({pet_id: @pet_1.id, application_id: @application_3.id})
    PetApplication.create!({pet_id: @pet_3.id, application_id: @application_1.id})
    end

    it "Visitor can click approval button" do
      visit "/admin/applications/#{@application_1.id}"
      within ("#pet-#{@pet_3.id}") do
        click_on "Approve"
        expect(current_path).to eq("/admin/applications/#{@application_1.id}")
      end
      expect(page).to have_content("Approved")
    end

    it "Visitor can click reject button" do
      visit "/admin/applications/#{@application_2.id}"
      within ("#pet-#{@pet_2.id}") do
        click_on "Reject"
        expect(current_path).to eq("/admin/applications/#{@application_2.id}")
      end
      expect(page).to have_content("Rejected")
    end

    it "Visitor does not see approve or reject button when pet has been approved on another application" do

      visit "/admin/applications/#{@application_2.id}"
save_and_open_page
    
      expect(page).to have_content("#{@pet_1.name} has already been approved for adoption")
    end
  end
end
