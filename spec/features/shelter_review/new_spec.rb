require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit /shelters/:id' do
    before :each do
      @shelter_1 = Shelter.create!(
        name:    "The Feline Fix",
        address:  "6075 Parkway Drive",
        city:     "Denver",
        state:    "CO",
        zip:      "80022")

      @user_1 = User.create!(
        name:     "Mike Dao",
        address:  "1234 Taylor Swift Ave",
        city:     "Denver",
        state:    "CO",
        zip:      "80213")
    end
    it "User can add a new review for the shelter" do
      visit "/shelters/#{@shelter_1.id}"
      click_button "Add Review"
      expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/new")

      fill_in "title", with: "Best Place Ever"
      fill_in "rating", with: 5
      fill_in "content", with: "This is the best place ever. Come adopt your pet here"
      fill_in "reviewer_name", with: "#{@user_1.name}"

      click_button "Submit Review"
      expect(current_path).to eq("/shelters/#{@shelter_1.id}")

      review = Review.last
      expect(page).to have_content("#{review.title}")
      expect(page).to have_content("#{review.rating}")
      expect(page).to have_content("#{review.content}")
      expect(page).to have_content("#{@user_1.name}")
    end

    it "If user does not exist, can't create review" do
      visit "/shelters/#{@shelter_1.id}"
      click_button "Add Review"
      expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/new")

      fill_in "title", with: "Best Place"
      fill_in "rating", with: 4
      fill_in "content", with: "This is the best place ever. Come adopt your pet here"
      fill_in "reviewer_name", with: "Mike Doo"
      click_button "Submit Review"

      expect(page).to have_content("User does not exist. Please enter a valid user name")
    end
    it "Review has a default image if one is not entered by user" do
      visit "/shelters/#{@shelter_1.id}"
      click_button "Add Review"
      expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/new")

      fill_in "title", with: "Best Place"
      fill_in "rating", with: 4
      fill_in "content", with: "This is the best place ever. Come adopt your pet here"
      fill_in "reviewer_name", with: "Mike Dao"
      click_button "Submit Review"
      expect(page).to have_xpath("//img[@src='http://cdn.akc.org/content/article-body-image/black_labrador_retriever_puppies.jpg']")
    end
  end
end
