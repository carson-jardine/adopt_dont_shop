class Shelter < ApplicationRecord
  validates_presence_of :name
  has_many :pets, dependent: :destroy
  has_many :reviews
  has_many :applications, through: :pets

  def average_shelter_rating
    reviews.average(:rating)
  end

  def pet_count
    pets.count
  end

  def total_applications
    applications.count
  end

  def has_pending?
    applications.exists?(application_status: "Pending")
  end

end
