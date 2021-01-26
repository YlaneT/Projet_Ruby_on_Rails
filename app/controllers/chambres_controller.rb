class ChambresController < ApplicationController
    before_action :authenticate_admin!, only: [:new, :create]
    def index
        @chambres = Chambre.all   
    end

    def show
        @chambre = Chambre.find(params[:id])
    end

    def new

    end

    def create

    end
end
