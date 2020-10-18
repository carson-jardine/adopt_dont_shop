class Application < ApplicationRecord
  belongs_to :user
  validates_presence_of :description, on: :update
  has_many :pet_applications
  has_many :pets, through: :pet_applications
end
