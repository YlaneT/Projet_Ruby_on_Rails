class ChambreController < ApplicationController
	before_action :set_chambre, only: [:show, :edit, :update, :destroy]
	before_action :liste_types, only: [:index]

	def index
	  @chambres = Chambre.all
	end
  
	def new
	  @chambre = Chambre.new
	end
  
	def create
	  @chambre = Chambre.new(chambre_params)
	  @chambre.save
	  redirect_to chambre_path(@chambre)
	end
  
	def show
	end
  
	def edit
	end
  
	def update
	  @chambre.update(chambre_params)
	  redirect_to chambre_path(@chambre)
	end
  
	def destroy
	  @chambre.destroy
	  redirect_to chambres_path
	end
  
	def chef
	  @chef = @chambre.chef
	end
  
	def top
	  @chambres = Chambre.where(rating: 5)
	end
  
	private
  
	def set_chambre
	  @chambre = Chambre.find(params[:id])
	end

	
	def liste_types
		@chambres = Chambre.all
		@types=Array.new
		@nbs=Array.new
		@chambres.each do |c|
			if @types.find_index(c.type_c) === nil
				@types.push(c.type_c)
				@nbs.push(1)
			else
				pos = @types.find_index(c.type_c)
				@nbs[pos] += 1
			end
		end
	end

	def get_nb_par_type (type_c)
		Chambre.liste_types
		@nbs[@types.find_index(type_c)]
	end
  
	def chambre_params
	  params.require(:chambre).permit(:num, :type_c, :prix)
	end
end
