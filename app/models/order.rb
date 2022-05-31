class Order < ApplicationRecord
    
    before_create :code_generate
    belongs_to :shipping_company
    has_many :vehicles
    has_many :shipping_statuses
    enum status: {pendente_de_aceite: 0, aceita: 1, recusada: 2}, _default: :pendente_de_aceite

    validates :shipping_price, :delivery_time, presence: true
    
    private
    def self.price_calculator(product, shipping_company)
        # debugger
        dimension_basead_price = (product.width * product.height * product.depth)/1000000 * shipping_company.price_dimensions
        distance_based_price = product.distance * shipping_company.price_km
        weight_based_price = product.weight * shipping_company.price_weight
        shipping_price = dimension_basead_price + distance_based_price + weight_based_price
        if shipping_price < shipping_company.minimal_price
            return number_formater(shipping_company.minimal_price)
        end
        if shipping_price.to_s.length >= 5
            shipping_price = shipping_price.to_s.slice(0..4).to_f
        end
        return shipping_price
    end
    
    def self.deadline_calculator(product, shipping_company)
        delivery_time = shipping_company.deadline_km * product.distance/30
        if delivery_time.zero?
            return 1
        end
        return shipping_company.deadline_km * product.distance/30
    end
  
    def code_generate
        self.code = SecureRandom.alphanumeric(15)
        code_generate if Order.exists?(code: self.code)
    end

    def self.number_formater(number)
        before_dot_number= number.to_s.split('.')[0]
        after_dot_number = number.to_s.split('.')[1]
        if after_dot_number.length == 1
            return (number.to_s + '0').to_f
        elsif after_dot_number == 2
            return number
        end
        return number.to_s.slice(0..4).to_f
    end

end
