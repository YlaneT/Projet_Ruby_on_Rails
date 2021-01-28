class ChambresController < ApplicationController
    
    def index
        @chambres = policy_scope(Chambre)
        @chambres = Chambre.all   
    end

    def show
        @chambre = Chambre.find(params[:id])
        authorize @chambre
    end

    def new

    end

    def create

    end
end
