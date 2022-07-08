require 'rails_helper'

describe 'user visits shipping companies vehicles register screen' do
    it 'sucessfully' do
        shipping_company = ShippingCompany.create!(email_domain: 'loja99.com', cnpj: '00000000000000', 
        corporate_name: '99 LTDA', brand_name: '99 CENTAVOS', full_adress: 'Rua dos Padres, 101')
        user = User.create(email: 'admin@loja99.com', password: 'password')

        login_as(user, :scope => :user)
        visit(root_path)
        click_on('Veículos')
        click_on('Cadastrar Veículo')

        expect(current_path).to eq new_user_shipping_company_vehicle_path(user.shipping_company) 
    end

    it 'and register a vehicle sucessfully' do
        shipping_company = ShippingCompany.create!(email_domain: 'loja99.com', cnpj: '00000000000000', 
        corporate_name: '99 LTDA', brand_name: '99 CENTAVOS', full_adress: 'Rua dos Padres, 101')
        user = User.create(email: 'admin@loja99.com', password: 'password')

        login_as(user, :scope => :user)
        visit(root_path)
        click_on('Veículos')
        click_on('Cadastrar Veículo')
        fill_in('Modelo do Veículo', with: 'Fusca')
        fill_in('Marca do Veículo', with: 'Volks')
        fill_in('Placa do Veículo', with: 'FSA3175')
        fill_in('Ano de Fabricação', with: '1967')
        fill_in('Peso máximo', with: '120')
        click_on('Cadastrar')

        expect(page).to have_content('Veículo cadastrado com SUCESSO!')
        expect(page).to have_content('Fusca')
        expect(page).to have_content('Volks')
        expect(page).to have_content('FSA3175')
    end

    it 'and unsuccessfully registers a vehicle with non-valid data' do
        shipping_company = ShippingCompany.create!(email_domain: 'loja99.com', cnpj: '00000000000000', 
        corporate_name: '99 LTDA', brand_name: '99 CENTAVOS', full_adress: 'Rua dos Padres, 101')
        user = User.create(email: 'admin@loja99.com', password: 'password')
        vehicle = Vehicle.create!(license_plate: 'FSA3175', fabrication_year: '2002', car_model: 'F-250',
        max_weight: '400', car_brand: 'Chevrolet', shipping_company: user.shipping_company)

        login_as(user, :scope => :user)
        visit(root_path)
        click_on('Veículos')
        click_on('Cadastrar Veículo')
        fill_in('Modelo do Veículo', with: '')
        fill_in('Marca do Veículo', with: 'Volks')
        fill_in('Placa do Veículo', with: 'FSA3175')
        fill_in('Ano de Fabricação', with: '1967')
        fill_in('Peso máximo', with: '120')
        click_on('Cadastrar')

        expect(page).to have_content('Falha ao cadastrar Veículo!')
        expect(page).to have_content('Placa do Veículo já está em uso')
        expect(page).to have_content('Modelo do Veículo não pode ficar em branc')
    end

    it 'and needs to be logged in' do
        shipping_company = ShippingCompany.create!(email_domain: 'loja99.com', cnpj: '00000000000000', 
        corporate_name: '99 LTDA', brand_name: '99 CENTAVOS', full_adress: 'Rua dos Padres, 101')

        visit(new_user_shipping_company_vehicle_path(shipping_company))

        expect(current_path).to eq new_user_session_path
        expect(page). to have_content('Para continuar, faça login ou registre-se.')
    end
end