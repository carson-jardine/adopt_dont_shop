require 'rails_helper'

describe Shelter, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
  end
  describe "relationships" do
    it {should have_many :pets}
    it {should have_many :reviews}
  end

  describe "instance methods" do
    before :each do
      @shelter_1 = Shelter.create({
        name:    "The Feline Fix",
        address:  "6075 Parkway Drive",
        city:     "Denver",
        state:    "CO",
        zip:      "80022"})
      @user_1 = User.create({
        name:     "Mike Dao",
        address:  "123 Taylor Swift Ave",
        city:     "Denver",
        state:    "CO",
        zip:      "80213"})
      @review_1 = Review.create({
        title: "Best Place Ever",
        rating: 5,
        content: "The vets were nice af",
        optional_image: "https://sayingimages.com/wp-content/uploads/You-Got-It-meme.jpg",
        reviewer_name: "#{@user_1.name}",
        user_id: "#{@user_1.id}",
        shelter_id: "#{@shelter_1.id}"})
      @review_2 = Review.create!({
        title: "Worst Place Ever",
        rating: 2,
        content: "The vets were stupid af af",
        optional_image: "https://sayingimages.com/wp-content/uploads/You-Got-It-meme.jpg",
        reviewer_name: "#{@user_1.name}",
        user_id: "#{@user_1.id}",
        shelter_id: "#{@shelter_1.id}"})
      @pet_1 = Pet.create(
        image: "http://cdn.akc.org/content/hero/cute_puppies_hero.jpg",
        name:  "Louis",
        description: "A very cute floof",
        approximate_age: 2,
        sex: "Male",
        adoption_status: "Adoptable",
        shelter_id: @shelter_1.id)
      @pet_2 = Pet.create(
        image: "http://cdn.akc.org/content/article-body-image/wirehaired_pointing_griffon_cute_puppies.jpg",
        name:  "Charlie",
        description: "A very handsome floof",
        approximate_age: 5,
        sex: "Male",
        adoption_status: "Pending",
        shelter_id: @shelter_1.id)
      @application_1 = Application.create!({
        user_id: "#{@user_1.id}",
        name: "#{@user_1.name}",
        application_status: 'Pending',
        description: 'testtest'
        })
      PetApplication.create!({pet_id: @pet_1.id, application_id: @application_1.id})
    end

    it ".average_shelter_rating" do
      expect(@shelter_1.average_shelter_rating.round(2)).to eq(3.5)
      expect(@shelter_1.average_shelter_rating.round(2)).to_not eq(1.5)
    end

    it ".pet_count" do
      expect(@shelter_1.pet_count).to eq(2)
      expect(@shelter_1.pet_count).to_not eq(5)
    end

    it ".total_applications" do
      expect(@shelter_1.total_applications).to eq(1)
      expect(@shelter_1.total_applications).to_not eq(2)
    end

    it ".has_pending?" do
      expect(@shelter_1.has_pending?).to eq(true)
    end

    it ".has_approved?" do
      expect(@shelter_1.has_approved?).to eq(false)
    end
  end
end
