require 'rails_helper'

describe 'Admin acess shipping companies page' do
    it 'sucessfully' do
        admin = Admin.create!(email: 'admin@sistemadefrete.com.br', password: 'password')

        login_as(admin, :scope => :admin)
        visit(root_path)
        click_on('Transportadoras')

        expect(current_path).to eq admin_shipping_companies_path 
    end

    it 'and see theres no shipping company registered' do
        admin = Admin.create!(email: 'admin@sistemadefrete.com.br', password: 'password')

        login_as(admin, :scope => :admin)
        visit(root_path)
        click_on('Transportadoras')

        expect(page).to have_content('Não há Transportadoras cadastradas')
    end

    it 'and see registered shipping companies' do
        admin = Admin.create!(email: 'admin@sistemadefrete.com.br', password: 'password')
        
        shipping_company = ShippingCompany.create!(email_domain: 'loja99.com', cnpj: '00000000000000', 
        corporate_name: '99 LTDA', brand_name: '99 CENTAVOS', full_adress: 'Rua dos Padres, 101')

        login_as(admin, :scope => :admin)
        visit(root_path)
        click_on('Transportadoras')

        expect(page).to have_content('99 CENTAVOS')
        expect(page).to have_content('Razão Social: 99 LTDA')
        expect(page).to have_content('Status: waiting')
    end

    it 'and needs to be logged in' do
        visit(admin_shipping_companies_path)

        expect(current_path).to eq new_admin_session_path
        expect(page). to have_content('Para continuar, faça login ou registre-se.')
    end

end