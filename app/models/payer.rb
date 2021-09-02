class Payer < ApplicationRecord
    has_many :transactions
    
    validates :points, numericality: { greater_than: -1 }
end
