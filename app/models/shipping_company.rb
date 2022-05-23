class ShippingCompany < ApplicationRecord
    has_many :vehicles
    has_many :users
    has_many :orders
    has_many :shipping_prices

    enum status: {waiting: 0, accepted: 1, active: 2, inactive: 3}

    validates :corporate_name, :brand_name, :cnpj, :email_domain, uniqueness: true
    validates :email_domain, :cnpj, :corporate_name, :brand_name, :full_adress, presence: true
    validates :price_dimensions, :price_km, :price_weight, :deadline_km, comparison: { greater_than_or_equal_to: 0}
    validates :price_dimensions, :price_km, :price_weight, numericality: {only_decimal: true}
    validates :deadline_km, numericality: {only_integer: true}
    validates :cnpj, length: { is: 14 }
end
