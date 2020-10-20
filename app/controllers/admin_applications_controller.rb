class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    @application_pet = PetApplication.find_by application_id: params[:id], pet_id: params[:pet_id]
    @application_pet.update({
              pet_status: "Approved"
              })
    @application_pet.save
    redirect_to "/admin/applications/#{params[:id]}"
  end
end
