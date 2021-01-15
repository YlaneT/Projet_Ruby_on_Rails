class ChambreController < ApplicationController
	before_action :set_chambre, only: [:show, :edit, :update, :destroy]

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

	def str
		return "Chambre n°" + @chambre.num
	end
  
	def chambre_params
	  params.require(:chambre).permit(:num, :type_c, :prix)
	end
end
