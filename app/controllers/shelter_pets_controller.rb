class ShelterPetsController < ApplicationController
  def index
    @shelter = Shelter.find(params[:id])
    #VVV not necessary can do .shelter.pets
    @pets = Shelter.find(params[:id]).pets
  end

  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    pet = Pet.new({
            name: params[:pet][:name],
            image: params[:pet][:image],
            description: params[:pet][:description],
            approximate_age: params[:pet][:approximate_age],
            sex: params[:pet][:sex],
            shelter_id: params[:id],
            adoption_status: "Adopatable"
            })
    pet.save
    #pet.save! is better bc it will throw an error if something is entered in incorrectly 
    redirect_to "/shelters/#{params[:id]}/pets"
  end

end
