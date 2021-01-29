class ReservationsController < ApplicationController
    before_action :authenticate_user!, only: [:index, :show, :create, :edit, :update, :destroy]
    before_action :set_reservation, only: [:show, :edit, :update, :destroy]

    def index
        # @job = TestJob.perform_later
        @reservations = policy_scope(Reservation)
        
        if (User.where("id = ? and admin = true", current_user.id).count > 0)
            if (params[:type_c] == nil or params[:type_c] == "")
                @reservations = Reservation.all
            else
                #Recherche (filtre)
                @reservations = Reservation.where(type_c: params[:type_c])
            end
            
        else
            if (params[:type_c] == nil or params[:type_c] == "")
                @reservations = Reservation.where(user_id: current_user.id)
            else
                #Recherche (filtre)
                @reservations = Reservation.where(user_id: current_user.id, type_c: params[:type_c])
            end
        end
        
 
    end


    def show
        @reservation = Reservation.find(params[:id])
    end

    def new
        @reservation = Reservation.new
        authorize @reservation
    end

    def create
        
        @reservation = Reservation.new(reservation_params)
        authorize @reservation
        
        @result = ReservationsService.new({
                type_c: params[:reservation][:type_c],
                date_d: params[:reservation][:date_d],
                date_f: params[:reservation][:date_f],
                reservation: @reservation,
                current_user: current_user
                }).ajout
                
        case @result
        when "Date erreur"
            render html: "<script> alert( 'Dates choisies invalides' )</script>".html_safe
        when "Non disponible"
            render html: "<script> alert( 'Chambre indisponible' )</script>".html_safe
        else
            redirect_to reservations_path
        end

    end

    
    def edit
        @reservation = Reservation.find(params[:id])
        authorize @reservation        
    end

    def update
        authorize @reservation
        @result = ReservationsService.new({
            type_c: params[:reservation][:type_c],
            date_d: params[:reservation][:date_d],
            date_f: params[:reservation][:date_f],
            reservation: @reservation,
            current_user: current_user
            }).ajout

        case @result
        when "Date erreur"
            render html: "<script> alert( 'Dates choisies invalides' )</script>".html_safe
        when "Non disponible"
            render html: "<script> alert( 'Chambre indisponible' )</script>".html_safe
        else
            @reservation.chambre = @chambre
            @reservation.update(reservation_params)
            redirect_to reservation_path(@reservation)
        end

        
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
