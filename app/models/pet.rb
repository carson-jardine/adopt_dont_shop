class Pet < ApplicationRecord
  belongs_to :shelter

  has_many :pet_applications
  has_many :applications, through: :pet_applications

  def self.search(search)
    if search
      self.where(["name ilike ?", "%#{search}%"])
    end
  end
end
