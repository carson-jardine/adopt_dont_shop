class ShelterReviewsController < ApplicationController

  def new
          @shelter = Shelter.find(params[:shelter_id])
          @users = User.all
  end
  def create
    
    @users = User.all
    @shelter = Shelter.find(params[:shelter_id])  
    @review = Review.new(review_params)
   
    if @review.save
      redirect_to "/shelters/#{@shelter.id}"
    else 
      flash[:notice] = "Review not created: Required information missing."
      render :new
    end
  end

  def edit
          @shelter = Shelter.find(params[:shelter_id])
          @users = User.all
          @review = Review.find(params[:review_id])
  end

  def update
    @users = User.all
    @shelter = Shelter.find(params[:shelter_id])
    @review = Review.find(params[:review_id])
    @review.assign_attributes(review_params)
    if @review.save
      redirect_to "/shelters/#{@shelter.id}"
    else
      flash[:notice] = "Review not updated: Required information missing"
      render :edit
      end
    end

  def destroy 
    shelter = Shelter.find(params[:shelter_id])
    Review.destroy(params[:review_id])
    redirect_to "/shelters/#{shelter.id}"
  end

  private 
  
  def review_params
    params.permit(:title, :review, :rating, :content, :user_id, :shelter_id, :optional_image, :reviewer_name)
  end
end