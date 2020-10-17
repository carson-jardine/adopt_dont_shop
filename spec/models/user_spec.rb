require 'rails_helper'

describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
  end
  describe 'relationships' do
    it { should have_many :reviews}
    it { should have_many :applications}
  end

  describe 'instance methods' do
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

      @review_1 = Review.create!({
        title: "Best Place Ever",
        rating: 5,
        content: "The vets were nice af",
        optional_image: "https://sayingimages.com/wp-content/uploads/You-Got-It-meme.jpg",
        reviewer_name: "#{@user_1.name}",
        user_id: "#{@user_1.id}",
        shelter_id: "#{@shelter_2.id}"})
      @review_2 = Review.create!({
        title: "Worst Place Ever",
        rating: 1,
        content: "The vets were stupid af",
        optional_image: "https://sayingimages.com/wp-content/uploads/You-Got-It-meme.jpg",
        reviewer_name: "#{@user_1.name}",
        user_id: "#{@user_1.id}",
        shelter_id: "#{@shelter_1.id}"})
      @review_3 = Review.create!({
        title: "Medicore Place Ever",
        rating: 2,
        content: "The vets were stupid af af",
        optional_image: "https://sayingimages.com/wp-content/uploads/You-Got-It-meme.jpg",
        reviewer_name: "#{@user_1.name}",
        user_id: "#{@user_1.id}",
        shelter_id: "#{@shelter_1.id}"})
      end

    it "#highlighted_reviews" do
     expect(@user_1.highlighted_reviews).to eq([@review_2, @review_1])
    end

    it "#average_user_rating" do
      expect(@user_1.average_user_rating.round(2)).to eq(2.67)
    end
  end
end
