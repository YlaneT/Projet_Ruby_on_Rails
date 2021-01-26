class ReservationsController < ApplicationController
    before_action :authenticate_user!, only: [:index, :show, :create, :edit, :update, :destroy]
    before_action :set_reservation, only: [:show, :edit, :update, :destroy]



    def index
        @reservations = policy_scope(Reservation)
        
        #@reservations = Reservation.all
        if (User.where("id = ? and admin = true", current_user.id).count > 0)
            @reservations = Reservation.all
        else
            @reservations = Reservation.where(user_id: current_user.id)
        end

        
        
        # @reservations = Reservation.where(date_d: "2021-01-21")
        
    end

    def home
        # @reservation = Reservation.new
        # @reservations = Reservation.all
    end

    def show
        @reservation = Reservation.find(params[:id])

        
    end


    def new
        #params[:chambre_id] = "3"
        

        #@chambre = Chambre.find(params[:chambre_id])
        @reservation = Reservation.new
        authorize @reservation
    end

    def create
        @reservation = Reservation.new(reservation_params)
        authorize @reservation
        
        ReservationsService.new({
                type_c: params[:reservation][:type_c],
                date_d: params[:reservation][:date_d],
                date_f: params[:reservation][:date_f],
                reservation: @reservation,
                current_user: current_user
                }).ajout

        # #if(Reservation.where("date_d < ? AND date_f > ?", params[:date_f], params[:date_d] )).empty?
        # #params[:chambre_id] = "2"
        # #params[:chambre_id] = var[params[:type_c]]

        # if(params[:reservation][:type_c] == "0")
        #     #params[:chambre_id] = "1"
        #     params[:reservation][:type_c] = "A"
        #     @chambre = Chambre.find(1)
        # end
        # if(params[:reservation][:type_c] == "1")
        #     #params[:chambre_id] = "2"
        #     params[:reservation][:type_c] = "B"
        #     @chambre = Chambre.find(2)
        # end
        # if(params[:reservation][:type_c] == "2")
        #     @chambre = Chambre.find(3)
        # end
        # if(params[:reservation][:type_c] == "3")
        #     #params[:chambre_id] = "4"
        #     @chambre = Chambre.find(4)
        # end    

        
        # if (((params[:reservation][:date_d]) >= Date.today.to_s) and ((params[:reservation][:date_d]) < (params[:reservation][:date_f])))
        #     nbre= Reservation.where("Date(date_d) < ? AND Date(date_f) > ? AND type_c = ?", params[:reservation][:date_f], params[:reservation][:date_d], params[:reservation][:type_c]).count
        #     #if (nbre.to_i < (Chambre.where(id: @chambre).map { |p| p.num }))
            
        #     if (Chambre.where("id = ? AND num > ?", @chambre, nbre).length > 0)
                
                

        #         @reservation.chambre = @chambre
        #         @reservation.user = current_user
        #         @reservation.save
        #         redirect_to "/reservations"
        #     else
        #         #render "reservations", :alert => 'sddsjsd'
                
        #         redirect_to "/reservations/new"
        #     end
        # else
        #     render html: "<script> alert( '*ton_message*' )</script>".html_safe
        # end

        

        # #if (Chambre.where(id: 2))
        
        # # #params[:chambre_id] = "3"
        #     @reservation = Reservation.new(reservation_params)
        #     #@chambre = Chambre.find(params[:chambre_id])
        #     @reservation.chambre = @chambre
        #     @reservation.user = current_user
        #     @reservation.save

        #redirect_to '/reservations'

    end

    
    def edit
        @reservation = Reservation.find(params[:id])
        authorize @reservation        
    end

    def update
        if(params[:reservation][:type_c] == "0")
            #params[:chambre_id] = "1"
            @chambre = Chambre.find(1)
        end
        if(params[:reservation][:type_c] == "1")
            #params[:chambre_id] = "2"
            @chambre = Chambre.find(2)
        end
        if(params[:reservation][:type_c] == "2")
            @chambre = Chambre.find(3)
        end
        if(params[:reservation][:type_c] == "3")
            #params[:chambre_id] = "4"
            @chambre = Chambre.find(4)
        end  
        @reservation.update(reservation_params)
        @reservation.chambre = @chambre
        redirect_to reservation_path(@reservation)
    end

    def destroy
        @reservation.destroy
        authorize @reservation
        redirect_to reservations_path
    end

    private

    def set_reservation
        @reservation = Reservation.find(params[:id])
        authorize @reservation
      end

    def reservation_params
        params.require(:reservation).permit(:date_d, :date_f, :type_c)
    end

end
