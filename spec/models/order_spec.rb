require 'rails_helper'

describe Order do
    it { should validate_presence_of(:shipping_price) }
    it { should validate_presence_of(:delivery_time) }
    it { should belong_to(:shipping_company) }

    it 'and must have a code when create a new order' do 
        shipping_company = ShippingCompany.create!(email_domain: 'loja99.com', cnpj: '00000000000000', 
                corporate_name: '99 LTDA', brand_name: '99 CENTAVOS', full_adress: 'Rua dos Padres, 101',
                status: :accepted)
        order = Order.create!(shipping_price: 99, shipping_company: shipping_company, delivery_time: 1)

        order.save
        result = order.code

        expect(result).not_to be_empty
        expect(result.length).to eq 15
    end

    it 'generate another code if repeats' do 
        product_1 = Product.create!(customer_name: 'Arthur', customer_address: 'Rua dos Anjos, 101',
        distance: 100, weight: 2000, height: 10, width: 20, depth: 5)
        product_2 = Product.new(customer_name: 'Wesley', customer_address: 'Rua dos Demonios, 666',
        distance: 300, weight: 6000, height: 15, width: 10, depth: 10) 
        allow(SecureRandom).to receive(:alphanumeric).with(15).and_return(product_1.code, SecureRandom.alphanumeric(15)) 
     
        # product_2.save 
        # expect(product_1.code).to_not eq(product_2.code) 
    end
end
