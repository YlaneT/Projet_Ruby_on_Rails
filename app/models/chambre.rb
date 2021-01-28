class Chambre < ApplicationRecord
    has_many :reservations, dependent: :destroy
    has_many :reviews, dependent: :destroy
    has_one_attached :photo

    enum type_chambre: ["A", "B", "C","D"]


end
