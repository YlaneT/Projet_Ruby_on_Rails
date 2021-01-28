class Chambre < ApplicationRecord
    has_many :reservations
    has_many :reviews

    enum type_chambre: ["A", "B", "C","D"]


end
