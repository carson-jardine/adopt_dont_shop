class Shelter < ApplicationRecord
  validates_presence_of :name
  has_many :pets
  has_many :reviews

  def average_shelter_rating
    reviews.average(:rating)
  end

  def total_applications
    pets.count do |pet|
      pet.applications
    end
  end
end
