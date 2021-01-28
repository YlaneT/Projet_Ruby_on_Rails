class Review < ApplicationRecord
  belongs_to :chambre
  belongs_to :user
end
