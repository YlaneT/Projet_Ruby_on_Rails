class Reservation < ApplicationRecord  
  belongs_to :user
  belongs_to :chambre
  validates :date_d, :date_f, :type_c, presence: true   

end
