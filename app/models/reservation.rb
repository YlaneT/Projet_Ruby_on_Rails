class Reservation < ApplicationRecord
  enum type_chambre: ["A", "B", "C","D"]
  
  belongs_to :user
  belongs_to :chambre

  # before_validation :check

  validates :date_d, :date_f, :type_c, presence: true


  # def check(date_d, date_f, type_c)
  #   nbre= Reservation.where("Date(date_d) < ? AND Date(date_f) > ? AND type_c = ?", :date_f, :date_d, :type_c).count

  #   if (nbre < 5)
  #     return true
  #   else
  #     return false
  #   end
  # end


      

end
