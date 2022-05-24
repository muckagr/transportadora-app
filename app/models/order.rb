class Order < ApplicationRecord
    before_validation :code_generate
    belongs_to :shipping_company
    has_many :vehicles
    enum status: {pendente_de_aceite: 0, aceita: 1, recusada: 2}, _default: :pendente_de_aceite

    validates :shipping_price, presence: true
    
    private
    def self.price_calculator(product, shipping_company)
        dimension_basead_price = (product.width * product.height * product.depth)/100 * shipping_company.price_dimensions
        distance_based_price = product.distance * shipping_company.price_km
        weight_based_price = product.weight * shipping_company.price_weight
        shipping_price = dimension_basead_price + distance_based_price + weight_based_price
        if shipping_price < shipping_company.minimal_price
            return shipping_company.minimal_price
        end
        return shipping_price
    end
    
    def self.deadline_calculator(product, shipping_company)
        return shipping_company.deadline_km * product.distance/30
    end
  
    def code_generate
        if self.code.nil?
        gen_code = SecureRandom.alphanumeric(15).upcase
        if !Product.exists?(code: gen_code)
            self.code = gen_code
        end
        end
    end
end
