class ReservationsService
    def initialize(params)
        @type_c = params[:type_c]
        @date_d = params[:date_d]
        @date_f = params[:date_f]
        @reservation = params[:reservation]
        @current_user = params[:current_user]
    end

    def ajout
        @chambre = Chambre.find(Chambre.where(type_c: @type_c).ids).slice!(0)

        if (((@date_d) >= Date.today.to_s) and ((@date_d) < (@date_f)))
            
            nbre= Reservation.where("Date(date_d) < ? AND Date(date_f) > ? AND type_c = ?", @date_f, @date_d, @type_c).count
            #if (nbre.to_i < (Chambre.where(id: @chambre).map { |p| p.num }))
            
            if (Chambre.where("id = ? AND nb > ?", @chambre, nbre).length > 0)
                @reservation.chambre = @chambre
                @reservation.user = @current_user
                @reservation.save
                # redirect_to "/reservations"
                return "/reservations"
            else
                #render "reservations", :alert => 'sddsjsd'
                return "Non disponible"
                # redirect_to "/reservations/new"
            end
        else
            return "Date erreur"
        end
    end

    def modifier
        @chambre = Chambre.find(Chambre.where(type_c: @type_c).ids).slice!(0)

        if (((@date_d) >= Date.today.to_s) and ((@date_d) < (@date_f)))
            
            nbre= Reservation.where("Date(date_d) < ? AND Date(date_f) > ? AND type_c = ?", @date_f, @date_d, @type_c).count
            
            if (Chambre.where("id = ? AND nb > ?", @chambre, nbre).length > 0)
                return true
            else
                #render "reservations", :alert => 'sddsjsd'
                return "Non disponible"
                # redirect_to "/reservations/new"
            end
        else
            return "Date erreur"
        end
    end
end