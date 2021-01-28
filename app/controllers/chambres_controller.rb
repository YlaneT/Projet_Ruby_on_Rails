class ChambresController < ApplicationController
	skip_before_action :verify_authenticity_token
	# Ne vérifie pas si un utilisateur est connecté ou non
	# A modifier avec setup d'auth

	before_action :set_chambre, only: [:edit, :update, :destroy]
	# before_action :liste_types, only: [:index]
	

	def index
	  @chambres = Chambre.all
	end
  
	def new
		@room = Chambre.new
	end

	def create
		@room = Chambre.new(chambre_params)
		begin
			if @room.save
				redirect_to :chambres
			end
		end
	rescue ActiveRecord::RecordNotUnique
		@room.errors.add :type_c, "Le type de chambre doit être unique"
		render html: "<script>alert('Ce type de chambre existe déjà !')</script>".html_safe
	end
  
  
	def update
	  @chambre.update(chambre_params)
	  redirect_to chambre_path(@chambre)
	end
  
	def destroy
	  @chambre.destroy
	  redirect_to chambre_index_path
	end
  
	private
  
	def set_chambre
	  @chambre = Chambre.find(params[:id])
	end

	def chambre_params
	  params.require(:chambre).permit(:type_c, :nb, :prix)
	end
end
