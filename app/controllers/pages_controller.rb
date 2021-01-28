class PagesController < ApplicationController

    def index
        if (User.where("id = ? and admin = true", current_user.id).count > 0)
            @utilisateur = User.all
        else
            redirect_to '/reservations'
        end
            
    end

    def show
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
