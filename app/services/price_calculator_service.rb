class PriceCalculatorService
    attr_accessor :width, :depth, :height, :weight, :shipping_company, :shipping_price_configuration

    def initialize(product, shipping_company, shipping_price, shipping_price_configuration)
        @shipping_company = shipping_company
        @shipping_price_configuration = shipping_company.price_range
    end

     def calculate_delivery_price
        @shipping_company.height * @shipping_company.width * @shipping_company * get_right_price_range
     end

     def get_right_price_range
        right_range = shipping_company.price_range.where(dimensao >= min && dimensao <= max && peso >= min && peso <= max)
        right_range.price_km
     end
end