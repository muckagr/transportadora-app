require 'rails_helper'

describe 'User visits shippipng company vehicles page' do
    it 'and see all his shipping company registered vehicles' do
        shipping_company = ShippingCompany.create!(email_domain: 'loja99.com', cnpj: '00000000000000', 
        corporate_name: '99 LTDA', brand_name: '99 CENTAVOS', full_adress: 'Rua dos Padres, 101')
        user = User.create(email: 'admin@loja99.com', password: 'password')
        vehicle = Vehicle.create(license_plate: 'HZH5685', fabrication_year: '2015', car_model: 'Toro',
        max_weight: '100', car_brand: 'FIAT', shipping_company: shipping_company)

        login_as(user, :scope => :user)
        visit(root_path)
        click_on('Veículos')
        
        expect(page).to have_content('Toro')
        expect(page).to have_content('FIAT')
        expect(page).to have_content('HZH5685')
    end

    it 'and see theres no registered cars' do
        shipping_company = ShippingCompany.create!(email_domain: 'loja99.com', cnpj: '00000000000000', 
        corporate_name: '99 LTDA', brand_name: '99 CENTAVOS', full_adress: 'Rua dos Padres, 101')
        user = User.create(email: 'admin@loja99.com', password: 'password')

        login_as(user, :scope => :user)
        visit(root_path)
        click_on('Veículos')
        
        expect(page).to have_content('Não há veículos cadastrados')
    end
end