class Chambre < ApplicationRecord
    has_many :reservations

    enum type_chambre: ["A", "B", "C","D"]


end
