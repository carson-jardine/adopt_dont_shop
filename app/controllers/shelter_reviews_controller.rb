class ShelterReviewsController < ApplicationController

  def new
          @shelter = Shelter.find(params[:shelter_id])
          @users = User.all
  end
  def create
            
          shelter = Shelter.find(params[:shelter_id])  
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

    review.save

    redirect_to "/shelters/#{shelter.id}"
    
  end

  def destroy 
    shelter = Shelter.find(params[:shelter_id])
    Review.destroy(params[:review_id])
    redirect_to "/shelters/#{shelter.id}"
  end
end