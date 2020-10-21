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
    if User.name_exists?(params[:applicant_name])
      @application = Application.new(application_params)
      @application.assign_attributes({application_status: 'In Progress'})
      @application.user_id = User.find_by(name: params[:applicant_name]).id
      @application.save
      redirect_to "/applications/#{@application.id}"

    else
      flash[:notice] = "User does not exist. Please enter a valid user name"
      return render :new
    end
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

  private

  def application_params
    params.permit(:name, :applicant_name, :user_id, :application_status, :description)
  end
end
