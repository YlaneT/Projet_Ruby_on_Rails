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
		@room.save
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
	
	# def liste_types
	# 	chambres = Chambre.all
	# 	@types=Array.new
	# 	@nbs=Array.new
	# 	chambres.each do |c|
	# 		if @types.find_index(c.type_c) === nil
	# 			@types.push(c.type_c)
	# 			@nbs.push(1)
	# 		else
	# 			pos = @types.find_index(c.type_c)
	# 			@nbs[pos] += 1
	# 		end
	# 	end
	# end

	# def get_nb_par_type (type_c)
	# 	Chambre.liste_types
	# 	@nbs[@types.find_index(type_c)]
	# end
  
	def chambre_params
	  params.require(:chambre).permit(:type_c, :nb, :prix)
	end
end
