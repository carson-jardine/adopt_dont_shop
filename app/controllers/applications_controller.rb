class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    if params[:search]
      @adoption_pets = Pet.search(params[:search])
    end
  end

  def new
    @users = User.all
  end

  def create
    @application = Application.create({
      name: params[:user_id],
      user_id: params[:user_id],
      application_status: 'In Progress'
      })

    redirect_to "/applications/#{@application.id}"
  end

  def update

    application = Application.find(params[:id])
    application.assign_attributes({
      description: params[:Description],
      application_status: 'Pending'
      })

    if application.save
      redirect_to "/applications/#{application.id}"
    else

      flash[:notice] = "Fill Out Description"
      redirect_to "/applications/#{application.id}"
    end
  end
end
