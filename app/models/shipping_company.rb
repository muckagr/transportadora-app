class ShippingCompany < ApplicationRecord
    has_many :vehicles
    has_many :users
    has_many :orders

    enum status: {waiting: 0, accepted: 1, active: 2, inactive: 3}

    validates :corporate_name, :brand_name, :cnpj, :email_domain, uniqueness: true
    validates :email_domain, :cnpj, :corporate_name, :brand_name, :full_adress, presence: true
    validates :cnpj, length: { is: 14 }
end
