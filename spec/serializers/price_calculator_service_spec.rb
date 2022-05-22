# require 'rails_helper'

# describe PriceCalculatorService do
#     it 'must calculate shipping price' do
#         product = Product.create!(weight: 1000, height: 10,
#         width: 25, depth: 10, code: 'LALALA', distance: 100, status: :waiting_for_order, )
#         shipping_company = ShippingCompany.create!(email_domain: 'loja99.com', cnpj: '00000000000000', 
#         corporate_name: '99 LTDA', brand_name: '99 CENTAVOS', full_adress: 'Rua dos Padres, 101', status: :active)
#         shipping_company_2 = ShippingCompany.create!(email_domain: 'comper.com', cnpj: '00000002200000', 
#         corporate_name: 'COMPER LTDA', brand_name: 'COMPER', full_adress: 'Rua dos Santos, 101', status: :active)
        
#         calculate = PriceCalculatorService.new(product).calculate_delivery_price
#         # ShippingCompany.all.each do |sp|
#         #     PriceCalculatorService.new(product, sp)

#         expect(calculate.len).to eq 2
#     end
# end

# # product = Product.create!(weight: 1000, height: 10,
# # width: 25, depth: 10, code: 'LALALA', distance: 100, status: :waiting)

# # @shipping_companies = ShippingCompany.all.active
# #     @shipping_companies.each do |sp|
# #         <p><%= sp.brand_name %> price: <%= PCS.new(product, shipping_company).calculate_delivery_price %>

# {}


