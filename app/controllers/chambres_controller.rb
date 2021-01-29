class ChambresController < ApplicationController
    #skip_before_action :verify_authenticity_token
	# Ne vérifie pas si un utilisateur est connecté ou non
	# A modifier avec setup d'auth

	before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]

	before_action :set_chambre, only: [:edit, :update, :destroy]
	# before_action :liste_types, only: [:index]
	

	def index
		#Affichage de tous les types de chambres
		@chambres = policy_scope(Chambre)
	  	@chambres = Chambre.all
	end

	def show
		#Affichage details d'un type de chambre
		@user = current_user
		@chambre = Chambre.find(params[:id])
		authorize @chambre
	end
  
	def new
		#Creation d'un nouveau type de chambre
		@chambre = Chambre.new
		authorize @chambre		
	end

	def create
		#Ajout du nouveau type en bdd
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
		#Modifier les infos d'un type de chambre
		@chambre = Chambre.find(params[:id])
        authorize @chambre        
    end
  
	def update
		#Application de la modification en bdd
		authorize @chambre
		@chambre.update(chambre_params)
		redirect_to chambre_path(@chambre)
	end
  
	def destroy
		#Supprimer un type de chambre
		authorize @chambre
	  	@chambre.destroy
	  	redirect_to "/chambres"
	end
  
	private
  
	def set_chambre
	  @chambre = Chambre.find(params[:id])
	end

	def chambre_params
	  params.require(:chambre).permit(:type_c, :nb, :prix, :description, :photo)
	end
end
