class Pet < ApplicationRecord
  belongs_to :shelter

  has_many :pet_applications
  has_many :applications, through: :pet_applications

  def self.search(search)
    if search 
      pet_id = Pet.find_by(name: search)
        if pet_id 
          self.where(id: pet_id)
        else
          "No pets match your search"
        end
      else 
        "No pets match your search"
    end
  end
end
