class PagesController < ApplicationController
    before_action :authenticate_user!, only: [:index, :show]
    def index
        #affichage de la liste des utilisateurs inscrits sur le site
        if (User.where("id = ? and admin = true", current_user.id).count > 0)
            @utilisateur = User.all
        else
            redirect_to '/reservations'
        end
            
    end

    def home
        #page d'accueil
    end

    def show
        #modifie le statut d'un utilisateur (Admin ou User)
        @user = User.find(params[:id_u])
        if @user == current_user
            render html: "<script> alert( 'Tu ne peux pas supprimer ton compte' )</script>".html_safe
        else
            if @user.admin == true
                @user.update(admin: false)
            else
                @user.update(admin: true)
            end
            redirect_to "/pages"
        end
    end

end
