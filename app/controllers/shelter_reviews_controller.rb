class ShelterReviewsController < ApplicationController

  def new
    @shelter = Shelter.find(params[:id])
    @users = User.all
  end
  def create
            
          shelter = Shelter.find(params[:id])  
          @review = Review.create(
            title: params[:review][:title],
            rating: params[:review][:rating],
            content: params[:review][:content],
            reviewer_name: params[:review][:reviewer_name],
            optional_image: params[:review][:optional_image],
            shelter_id: params[:review][:shelter_id],
            user_id: params[:review][:user_id]
            )
    @review.save!
    redirect_to "/shelters/#{shelter.id}"
  end
end