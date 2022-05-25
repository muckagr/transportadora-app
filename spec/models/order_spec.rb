require 'rails_helper'

describe Order do
    it { should validate_presence_of(:shipping_price) }
    it { should validate_presence_of(:delivery_time) }
    it { should belong_to(:shipping_company) }

    it 'have a code when create a new order' do 
        shipping_company = ShippingCompany.create!(email_domain: 'loja99.com', cnpj: '00000000000000', 
                corporate_name: '99 LTDA', brand_name: '99 CENTAVOS', full_adress: 'Rua dos Padres, 101',
                status: :accepted)
        order = Order.create!(shipping_price: 99, shipping_company: shipping_company, delivery_time: 1)

        order.save
        result = order.code

        expect(result).not_to be_empty
        expect(result.length).to eq 15
    end

    it 'and code is unique' do 
        shipping_company = ShippingCompany.create!(email_domain: 'loja99.com', cnpj: '00000000000000', 
        corporate_name: '99 LTDA', brand_name: '99 CENTAVOS', full_adress: 'Rua dos Padres, 101',
        status: :accepted)
        order_1 = Order.create!(shipping_price: 99, shipping_company: shipping_company, delivery_time: 1)
        order_2 = Order.new(shipping_price: 67, shipping_company: shipping_company, delivery_time: 2)

        order_2.save!

        expect(order_1.code).not_to eq order_2.code
    end

    it 'and generate another code if repeats' do 
        shipping_company = ShippingCompany.create!(email_domain: 'loja99.com', cnpj: '00000000000000', 
                corporate_name: '99 LTDA', brand_name: '99 CENTAVOS', full_adress: 'Rua dos Padres, 101',
                status: :accepted)
        order_1 = Order.create!(shipping_price: 99, shipping_company: shipping_company, delivery_time: 1)
        order_2 = Order.new(shipping_price: 67, shipping_company: shipping_company, delivery_time: 2)

        allow(SecureRandom).to receive(:alphanumeric).with(15).and_return(order_1.code, SecureRandom.alphanumeric(15)) 
     
        order_2.save 
        expect(order_1.code).to_not eq(order_2.code) 
    end

    it 'and generates a correct shipping_price' do
        shipping_company = ShippingCompany.create!(email_domain: 'loja99.com', cnpj: '00000000000000', 
                corporate_name: '99 LTDA', brand_name: '99 CENTAVOS', full_adress: 'Rua dos Padres, 101',
                price_km: 0.3, price_dimensions: 0.5, price_weight: 0.009, deadline_km: 2, minimal_price: 30)
        product = Product.create!(customer_name: 'Arthur', customer_address: 'Rua dos Anjos, 101',
                distance: 100, weight: 2000, height: 10, width: 20, depth: 5)

        shipping_price = Order.price_calculator(product, shipping_company)

        expect(sprintf('%.2f', shipping_price).to_f).to eq 48
    end

    it 'and generates a correct delivery time' do
        shipping_company = ShippingCompany.create!(email_domain: 'loja99.com', cnpj: '00000000000000', 
                corporate_name: '99 LTDA', brand_name: '99 CENTAVOS', full_adress: 'Rua dos Padres, 101',
                price_km: 0.3, price_dimensions: 0.5, price_weight: 0.009, deadline_km: 2, minimal_price: 30)
        product = Product.create!(customer_name: 'Arthur', customer_address: 'Rua dos Anjos, 101',
                distance: 100, weight: 2000, height: 10, width: 20, depth: 5)

        shipping_price = Order.deadline_calculator(product, shipping_company)

        expect(shipping_price).to eq 6
    end
end
