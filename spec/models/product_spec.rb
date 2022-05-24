require 'rails_helper'

describe Product do
    it { should validate_presence_of(:customer_name) }
    it { should validate_presence_of(:customer_address) }
    it { should validate_presence_of(:distance) }
    it { should validate_presence_of(:weight) }
    it { should validate_presence_of(:width) }
    it { should validate_presence_of(:height) }
    it { should validate_presence_of(:depth) }
    it { should validate_numericality_of(:distance).is_greater_than(0)}
    it { should validate_numericality_of(:weight).is_greater_than(0)}
    it { should validate_numericality_of(:width).is_greater_than(0)}
    it { should validate_numericality_of(:depth).is_greater_than(0)}
    it { should validate_numericality_of(:height).is_greater_than(0)}

    it 'must have a code' do
        product = Product.new(customer_name: 'Arthur', customer_address: 'Rua dos Anjos, 101',
        distance: 100, weight: 2000, height: 10, width: 20, depth: 5)

        result = product.valid?

        expect(result).to be true
    end

    it 'when create a new product' do 
        product = Product.create!(customer_name: 'Arthur', customer_address: 'Rua dos Anjos, 101',
        distance: 100, weight: 2000, height: 10, width: 20, depth: 5)

        product.save!
        result = product.code

        expect(result).not_to be_empty
        expect(result.length).to eq 15
    end

    it 'and code is unique' do 
        product_1 = Product.create!(customer_name: 'Arthur', customer_address: 'Rua dos Anjos, 101',
        distance: 100, weight: 2000, height: 10, width: 20, depth: 5)
        product_2 = Product.new(customer_name: 'Wesley', customer_address: 'Rua dos Demonios, 666',
        distance: 300, weight: 6000, height: 15, width: 10, depth: 10)

        product_2.save!

        expect(product_2.code).not_to eq product_1.code
    end

    it 'generate another code if repeats' do 
        product_1 = Product.create!(customer_name: 'Arthur', customer_address: 'Rua dos Anjos, 101',
        distance: 100, weight: 2000, height: 10, width: 20, depth: 5)
        product_2 = Product.new(customer_name: 'Wesley', customer_address: 'Rua dos Demonios, 666',
        distance: 300, weight: 6000, height: 15, width: 10, depth: 10) 
        allow(SecureRandom).to receive(:alphanumeric).with(15).and_return(product_1.code, SecureRandom.alphanumeric(15)) 
     
        product_2.save 
        expect(product_1.code).to_not eq(product_2.code) 
    end
end
