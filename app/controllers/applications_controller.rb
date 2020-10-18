class ApplicationsController < ApplicationController

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
    # application.save
    # @users = User.all
    # @shelter = Shelter.find(params[:shelter_id])
    # @review = Review.new(review_params)
    #
    # if @review.save
    #   redirect_to "/shelters/#{@shelter.id}"
    # else
    #   flash[:notice] = "Review not created: Required information missing."
    #   render :new
    # end
  end

  def show
    @application = Application.find(params[:id])
  end
end
