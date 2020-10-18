class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    @adoption_pets = Pet.search(params[:search])
  end

  def new
    @users = User.all
  end

  def create

    @application = Application.create({
      name: params[:user_id],
      user_id: params[:user_id],
      application_status: "In Progress"
      })
    redirect_to "/applications/#{@application.id}"

  end

end
