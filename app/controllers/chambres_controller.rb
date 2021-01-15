class ChambresController < ApplicationController

    def index
        @chambres = Chambre.all
    end
end
