class PetApplicationsController < ApplicationController
  def create
    application = Application.find(params[:id])
    pet_application = PetApplication.new({
            pet_id: params[:pet_id],
            application_id: params[:id]
            })
    pet_application.save
    redirect_to "/applications/#{application.id}"
  end

  def index
    @pet = Pet.find(params[:id])
  end
end
