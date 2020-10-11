class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    pet.update({
      name: params[:pet][:name],
      image: params[:pet][:image],
      description: params[:pet][:description],
      approximate_age: params[:pet][:approximate_age],
      sex: params[:pet][:sex],
      })

    pet.save

    redirect_to "/pets/#{pet.id}"
  end
end
