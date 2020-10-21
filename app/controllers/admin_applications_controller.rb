class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    @application = Application.find(params[:id])
    @application_pet = PetApplication.find_by application_id: params[:id], pet_id: params[:pet_id]

    @application_pet.update(pet_status: params[:pet_status])
    @application_pet.save

    application_rejected = @application.pet_applications.all.find do |app|
      app.pet_status == "Rejected"
    end
    application_no_status = @application.pet_applications.all.find do |app|
      app.pet_status == nil
    end
      if application_rejected == nil && application_no_status == nil
        @application.update(application_status: 'Approved')
        @application.save
      elsif application_rejected != nil && application_no_status == nil
        @application.update(application_status: 'Rejected')
        @application.save
      end
    redirect_to "/admin/applications/#{params[:id]}"
  end
end
