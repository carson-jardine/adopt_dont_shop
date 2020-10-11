class ShelterPetsController < ApplicationController
  def index
    @shelter = Shelter.find(params[:id])
    @pets = Shelter.find(params[:id]).pets
  end

end
