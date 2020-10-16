class ShelterReviewsController < ApplicationController

  def new
          @shelter = Shelter.find(params[:shelter_id])
          @users = User.all
  end
  def create
    @users = User.all
    @shelter = Shelter.find(params[:shelter_id])  
    @review = Review.new(review_params)
   require 'pry'; binding.pry
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
    shelter = Shelter.find(params[:shelter_id])
    review = Review.find(params[:review_id])
    # binding.pry
    # shelter.update(shelter_params)
    review.update({
              title: params[:review][:title],
              rating: params[:review][:rating],
              content: params[:review][:content],
              reviewer_name: params[:review][:reviewer_name],
              optional_image: params[:review][:optional_image]
              })



    redirect_to "/shelters/#{shelter.id}"
    
  end

  def destroy 
    shelter = Shelter.find(params[:shelter_id])
    Review.destroy(params[:review_id])
    redirect_to "/shelters/#{shelter.id}"
  end

  private 
  def review_params
    params.permit(:title, :rating, :content, :user_id)
  end
end