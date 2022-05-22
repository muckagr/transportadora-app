require 'rails_helper'

describe 'Admin visits shipping companies register screen' do 

    it 'sucessfully' do
        admin = Admin.create!(email: 'admin@sistemadefrete.com.br', password: 'password')

        login_as(admin, :scope => :admin)
        visit(root_path)
        click_on('Transportadoras')
        click_on('Cadastrar Transportadora')

        expect(current_path).to eq new_admin_shipping_company_path
    end

    it 'and see all the fields for registering shipping companies' do
        admin = Admin.create!(email: 'admin@sistemadefrete.com.br', password: 'password')

        login_as(admin, :scope => :admin)
        visit(root_path)
        click_on('Transportadoras')
        click_on('Cadastrar Transportadora')

        expect(page).to have_field('Domínio de E-mail')
        expect(page).to have_field('CNPJ')
        expect(page).to have_field('Razão Social')
        expect(page).to have_field('Nome Fantasia')
        expect(page).to have_field('Endereço')
        expect(page).to have_button('Cadastrar')
    end

    it 'and sucessfully register a shipping company' do
        admin = Admin.create!(email: 'admin@sistemadefrete.com.br', password: 'password')

        login_as(admin, :scope => :admin)
        visit(root_path)
        click_on('Transportadoras')
        click_on('Cadastrar Transportadora')
        fill_in('Razão Social', with: 'SEDEX LTDA')
        fill_in('Nome Fantasia', with: 'SEDEX')
        fill_in('CNPJ', with: '13130158000128')
        fill_in('Domínio de E-mail', with: 'sedex10.com.br')
        fill_in('Endereço', with: 'São Paulo/São paulo, Rua das Parnaíbas, 128')
        click_on('Cadastrar')

        expect(current_path).to eq admin_shipping_companies_path
        expect(page).to have_content('Transportadora cadastrada com SUCESSO!')
        expect(page).to have_content('SEDEX')
        expect(page).to have_content('Razão Social: SEDEX LTDA')
        expect(page).to have_content('Status:')
    end

    it 'and unsuccessfully registers a shipping company with non-valid data' do
        admin = Admin.create!(email: 'admin@sistemadefrete.com.br', password: 'password')
        
        shipping_company = ShippingCompany.create!(email_domain: 'loja99.com', cnpj: '00000000000000', 
        corporate_name: '99 LTDA', brand_name: '99 CENTAVOS', full_adress: 'Rua dos Padres, 101')

        login_as(admin, :scope => :admin)
        visit(root_path)
        click_on('Transportadoras')
        click_on('Cadastrar Transportadora')
        fill_in('Razão Social', with: '99 LTDA')
        fill_in('Nome Fantasia', with: '')
        fill_in('CNPJ', with: '00000000000000')
        fill_in('Domínio de E-mail', with: 'loja99.com')
        fill_in('Endereço', with: 'São Paulo/São paulo, Rua das Parnaíbas, 128')
        click_on('Cadastrar')

        expect(page).to have_content('Falha ao cadastrar!')
        expect(page).to have_content('Nome Fantasia não pode ficar em branco')
        expect(page).to have_content('Razão Social já está em uso')
        expect(page).to have_content('CNPJ já está em uso')
        expect(page).to have_content('Domínio de E-mail já está em uso')
    end
end