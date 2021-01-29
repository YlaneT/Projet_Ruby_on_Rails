class ReviewsController < ApplicationController
    before_action :authenticate_user!, only: [:show, :create, :edit, :update, :destroy]

    def show
        @review= Review.where(user_id: current_user.id)
        authorize @review
    end

    def new
        @chambre = Chambre.find(params[:chambre_id])
        @review = Review.new
        authorize @review        
    end

    def create
        @review = Review.new(review_params)
        authorize @review
        if (params[:review][:rating].to_i < 0) || (params[:review][:rating].to_i > 5)
            render html: "<script> alert( 'La note doit etre entre 0 et 5' )</script>".html_safe
        else
            @chambre = Chambre.find(params[:chambre_id])
            @review.chambre = @chambre
            @review.user = current_user
            @review.save
            redirect_to new_chambre_review_path(@chambre)
        end

    end

    # def destroy
    #     @review.destroy
    #     authorize @review
    #     redirect_to new_chambre_review_path()
    # end

    private

    def review_params
      params.require(:review).permit(:content, :rating)
    end
end
