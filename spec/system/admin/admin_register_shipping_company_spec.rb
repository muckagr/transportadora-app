require 'rails_helper'

describe 'Admin visita a tela de cadastro de transportadoras' do 

    it 'com sucesso' do
        admin = Admin.create(email: 'admin@admin.com.br', password: 'password')

        login_as(admin, :scope => :admin)
        visit(root_path)
        click_on('Transportadoras')
        click_on('Cadastrar Transportadora')

        expect(current_path).to eq new_admin_shipping_company_path
    end

    it 'e vê todos os campos para cadastro de transportadoras' do
        admin = Admin.create(email: 'admin@admin.com.br', password: 'password')

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

    it 'e cadastra uma transportadora com sucesso' do
        admin = Admin.create(email: 'admin@admin.com.br', password: 'password')

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
end