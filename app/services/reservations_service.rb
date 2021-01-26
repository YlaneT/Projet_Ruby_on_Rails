class ReservationsService
    def initialize(params)
        @type_c = params[:type_c]
        @date_d = params[:date_d]
        @date_f = params[:date_f]
        @reservation = params[:reservation]
        @current_user = params[:current_user]
    end

    def ajout
        
        if(@type_c == "0")
            #params[:chambre_id] = "1"
            @type_c = "A"
            @chambre = Chambre.find(1)
        end
        if(@type_c == "1")
            #params[:chambre_id] = "2"
            @type_c = "B"
            @chambre = Chambre.find(2)
        end
        if(@type_c == "2")
            @chambre = Chambre.find(3)
        end
        if(@type_c == "3")
            #params[:chambre_id] = "4"
            @chambre = Chambre.find(4)
        end   

        
        if (((@date_d) >= Date.today.to_s) and ((@date_d) < (@date_f)))
            
            nbre= Reservation.where("Date(date_d) < ? AND Date(date_f) > ? AND type_c = ?", @date_f, @date_d, @type_cc).count
            #if (nbre.to_i < (Chambre.where(id: @chambre).map { |p| p.num }))
            
            if (Chambre.where("id = ? AND num > ?", @chambre, nbre).length > 0)
                @reservation.chambre = @chambre
                @reservation.user = @current_user
                @reservation.save
                # redirect_to "/reservations"
            else
                #render "reservations", :alert => 'sddsjsd'
                
                # redirect_to "/reservations/new"
            end
        else
            return 'aaaa'
            # render html: "<script> alert( '*ton_message*' )</script>".html_safe
        end
    end
end