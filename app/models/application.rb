class Application < ApplicationRecord
  belongs_to :user
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  validates_presence_of :description, on: :update
end
