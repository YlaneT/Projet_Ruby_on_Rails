class Chambre < ApplicationRecord
    has_many :reservations, dependent: :destroy
    has_many :reviews, dependent: :destroy
    has_one_attached :photo

end
