require 'rails_helper'

describe 'User visits shippipng company vehicles page' do
    it 'and see all his shipping company registered vehicles' do
        shipping_company_1 = ShippingCompany.create!(email_domain: 'loja99.com', cnpj: '00000000000000', 
        corporate_name: '99 LTDA', brand_name: '99 CENTAVOS', full_adress: 'Rua dos Padres, 101')
        shipping_company_2 = ShippingCompany.create!(email_domain: 'loja1000.com', cnpj: '00000000200000', 
        corporate_name: '1000 LTDA', brand_name: '1000 CENTAVOS', full_adress: 'Rua dos Demônios, 101')
        user = User.create(email: 'admin@loja99.com', password: 'password')
        vehicle_1 = Vehicle.create(license_plate: 'HZH5685', fabrication_year: '2015', car_model: 'Toro',
        max_weight: '100', car_brand: 'FIAT', shipping_company: shipping_company_1)
        vehicle_2 = Vehicle.create!(license_plate: 'JJJ9237', fabrication_year: '2005', car_model: 'GOL', 
        car_brand: 'VOLKS', max_weight: 100, shipping_company: shipping_company_2)

        login_as(user, :scope => :user)
        visit(root_path)
        click_on('Veículos')
        
        expect(page).to have_content('Toro')
        expect(page).to have_content('FIAT')
        expect(page).to have_content('HZH5685')
        expect(page).not_to have_content('JJJ9237')
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

    it 'and needs to be logged in' do
        shipping_company = ShippingCompany.create!(email_domain: 'loja99.com', cnpj: '00000000000000', 
        corporate_name: '99 LTDA', brand_name: '99 CENTAVOS', full_adress: 'Rua dos Padres, 101')
        vehicle = Vehicle.create!(license_plate: 'FSA3175', fabrication_year: '2002', car_model: 'F-250',
        max_weight: '400', car_brand: 'Chevrolet', shipping_company: shipping_company)

        visit(user_shipping_company_vehicles_path(shipping_company))

        expect(current_path).to eq new_user_session_path
        expect(page). to have_content('Para continuar, faça login ou registre-se.')
    end
end