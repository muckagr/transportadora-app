require 'rails_helper'

describe 'Admin visit details page of a shipping company' do
    it 'and see additional informations' do
        admin = Admin.create(email: 'admin@sistemadefrete.com.br', password: 'password')
        shipping_company = ShippingCompany.create!(email_domain: 'loja99.com', cnpj: '00000000000000', 
        corporate_name: '99 LTDA', brand_name: '99 CENTAVOS', full_adress: 'Rua dos Padres, 101')

        login_as(admin, :scope => :admin)
        visit(root_path)
        click_on('Transportadoras')
        click_on('99 CENTAVOS')

        expect(page).to have_content("Nome Fantasia\n99 CENTAVOS")
        expect(page).to have_content("Domínio de E-mail\nloja99.com")
        expect(page).to have_content("Razão Social\n99 LTDA")
        expect(page).to have_content("Endereço\nRua dos Padres, 101")
        expect(page).to have_content("Preço por km\n")
        expect(page).to have_content("Preço por grama\n")
        expect(page).to have_content("Preço por m3\n")
        expect(page).to have_content("Dias úteis de prazo/30km\n")
        expect(page).to have_content("Status\n")
    end

    it 'and goes back to shipping companies page' do
        admin = Admin.create(email: 'admin@sistemadefrete.com.br', password: 'password')
        shipping_company = ShippingCompany.create!(email_domain: 'loja99.com', cnpj: '00000000000000', 
        corporate_name: '99 LTDA', brand_name: '99 CENTAVOS', full_adress: 'Rua dos Padres, 101')

        login_as(admin, :scope => :admin)
        visit(root_path)
        click_on('Transportadoras')
        click_on('99 CENTAVOS')
        click_on('Voltar')

        expect(current_path).to eq admin_shipping_companies_path
    end

    it 'and needs to be logged in' do
        shipping_company = ShippingCompany.create!(email_domain: 'loja99.com', cnpj: '00000000000000', 
        corporate_name: '99 LTDA', brand_name: '99 CENTAVOS', full_adress: 'Rua dos Padres, 101')

        visit(admin_shipping_company_path(shipping_company))

        expect(current_path).to eq new_admin_session_path
        expect(page). to have_content('Para continuar, faça login ou registre-se.')
    end
end