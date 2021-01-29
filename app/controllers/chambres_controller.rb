class ChambresController < ApplicationController
    #skip_before_action :verify_authenticity_token
	# Ne vérifie pas si un utilisateur est connecté ou non
	# A modifier avec setup d'auth

	before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]

	before_action :set_chambre, only: [:edit, :update, :destroy]
	# before_action :liste_types, only: [:index]
	

	def index
		@chambres = policy_scope(Chambre)
	  	@chambres = Chambre.all
	end

	def show
		@user = current_user
		@chambre = Chambre.find(params[:id])
		authorize @chambre
	end
  
	def new
		@chambre = Chambre.new
		authorize @chambre		
	end

	def create
		@chambre = Chambre.new(chambre_params)
		authorize @chambre
		@check = Chambre.where(type_c: params[:chambre][:type_c]).count
		if @check == 0
			@chambre.save
			redirect_to chambres_path
		else
			render html: "<script> alert( 'Chambre existe deja' )</script>".html_safe
		end
	end

	
	def edit
        @chambre = Chambre.find(params[:id])
        authorize @chambre        
    end
  
	def update
		authorize @chambre
		@chambre.update(chambre_params)
		redirect_to chambre_path(@chambre)
	end
  
	def destroy
	  @chambre.destroy
	  authorize @chambre
	  redirect_to chambres_path
	end
  
	private
  
	def set_chambre
	  @chambre = Chambre.find(params[:id])
	end

	def chambre_params
	  params.require(:chambre).permit(:type_c, :nb, :prix, :description, :photo)
	end
end
