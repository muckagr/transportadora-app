class Vehicle < ApplicationRecord
    belongs_to :shipping_company
    belongs_to :order, optional: true
    
    validates :license_plate, :fabrication_year, presence: true 
    validates :car_model, :max_weight, :car_brand, presence: true
    validates :license_plate, uniqueness: true
    validates :max_weight, comparison: { greater_than_or_equal_to: 0}
    validates :max_weight, numericality: {only_integer: true}
    validates :license_plate, length: { is: 7 }
end
