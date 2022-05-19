class ShippingCompany < ApplicationRecord
    has_many :vehicles
    has_many :users
    has_many :orders

    enum status: {inativa: 0, ativa: 1, desativada: 2}

    # validates :email_domain, :cnpj, :corporate_name, :brand_name, :full_adress
end
