class ReservationsService
    def initialize(params)
        #importation des parametre à utiliser
        @type_c = params[:type_c]
        @date_d = params[:date_d]
        @date_f = params[:date_f]
        @reservation = params[:reservation]
        @current_user = params[:current_user]
    end

    def ajout
        #Recuperation du type de chambre choisi
        @chambre = Chambre.find(Chambre.where(type_c: @type_c).ids).slice!(0)

        #verifier si la date debut de reservation n'est pas inferieure à la date d'aujourd'hui
        if (((@date_d) >= Date.today.to_s) and ((@date_d) < (@date_f)))
            
            #Calcul du nombre de reservations prises durant la periode choisie
            nbre= Reservation.where("Date(date_d) < ? AND Date(date_f) > ? AND type_c = ?", @date_f, @date_d, @type_c).count
            
            #Verification de la disponibilité de la chambre choisie
            if (Chambre.where("id = ? AND nb > ?", @chambre, nbre).length > 0)
                @reservation.chambre = @chambre
                @reservation.user = @current_user
                @reservation.save
                return "/reservations"
            else
                return "Non disponible"
            end
        else
            return "Date erreur"
        end
    end

    def modifier
        #Recuperation du type de chambre choisi
        @chambre = Chambre.find(Chambre.where(type_c: @type_c).ids).slice!(0)

        #verifier si la nouvelle date debut de reservation n'est pas inferieure à la date d'aujourd'hui
        if (((@date_d) >= Date.today.to_s) and ((@date_d) < (@date_f)))
            
            #Calcul du nombre de reservation prises durant la periode choisie
            nbre= Reservation.where("Date(date_d) < ? AND Date(date_f) > ? AND type_c = ?", @date_f, @date_d, @type_c).count
            
            #Verification de la disponibilité de la chambre choisie
            if (Chambre.where("id = ? AND nb > ?", @chambre, nbre).length > 0)
                return true
            else
                return "Non disponible"
            end
        else
            return "Date erreur"
        end
    end
end