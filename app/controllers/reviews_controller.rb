class ReviewsController < ApplicationController

    def show
        @review= Review.where(user_id: current_user.id)
        authorize @review
    end

    def new
        @chambre = Chambre.find(params[:chambre_id])
        @review = Review.new
        authorize @review
        
        #Review.find(1).created_at.strftime("%H-%M-%S")
    end

    def create
        @review = Review.new(review_params)
        authorize @review
        @chambre = Chambre.find(params[:chambre_id])
        @review.chambre = @chambre
        @review.user = current_user
        @review.save
        redirect_to new_chambre_review_path(@chambre)
    end

    private

    def review_params
      params.require(:review).permit(:content, :rating)
    end
end
