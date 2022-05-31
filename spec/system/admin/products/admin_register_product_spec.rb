require 'rails_helper'

describe 'Admin visits register products page' do
    it 'and see all required fields' do
        admin = Admin.create!(email: 'admin@sistemadefrete.com.br', password: 'password')

        login_as(admin, :scope => :admin)
        visit(root_path)
        click_on('Produtos')
        click_on('Cadastrar Produto')

        expect(page).to have_field('Nome do Cliente')
        expect(page).to have_field('Endereço do Cliente')
        expect(page).to have_field('Distância')
        expect(page).to have_field('Peso do Produto (g)')
        expect(page).to have_field('Altura do Produto (cm)')
        expect(page).to have_field('Largura do Produto (cm)')
        expect(page).to have_field('Profundidade do Produto (cm)')
    end

    it 'and unsuccessfully register a product' do
        admin = Admin.create!(email: 'admin@sistemadefrete.com.br', password: 'password')

        login_as(admin, :scope => :admin)
        visit(root_path)
        click_on('Produtos')
        click_on('Cadastrar Produto')
        fill_in('Nome do Cliente', with: '')
        fill_in('Endereço do Cliente', with: '')
        fill_in('Distância', with: '0')
        fill_in('Peso do Produto (g)', with: '0')
        fill_in('Altura do Produto (cm)', with: '0')
        fill_in('Largura do Produto (cm)', with: '0')
        fill_in('Profundidade do Produto (cm)', with: '0')
        click_on('Cadastrar')
        
        expect(page).to have_content('Falha ao cadastrar!')
        expect(page).to have_content('Nome do Cliente não pode ficar em branco')
        expect(page).to have_content('Endereço do Cliente não pode ficar em branco')
        expect(page).to have_content('Altura deve ser maior que 0')
        expect(page).to have_content('Width deve ser maior que 0')
        expect(page).to have_content('Depth deve ser maior que 0')
        expect(page).to have_content('Weight deve ser maior que 0')
        expect(page).to have_content('Distância deve ser maior que 0')
    end

    it 'and sucessfully register a product' do
        admin = Admin.create!(email: 'admin@sistemadefrete.com.br', password: 'password')

        login_as(admin, :scope => :admin)
        visit(root_path)
        click_on('Produtos')
        click_on('Cadastrar Produto')
        fill_in('Nome do Cliente', with: 'Joao')
        fill_in('Endereço do Cliente', with: 'São Paulo, SP, 101')
        fill_in('Distância', with: '350')
        fill_in('Peso do Produto (g)', with: '2098')
        fill_in('Altura do Produto (cm)', with: '10')
        fill_in('Largura do Produto (cm)', with: '15')
        fill_in('Profundidade do Produto (cm)', with: '10')
        click_on('Cadastrar')

        expect(page).to have_content('Produto cadastrado com SUCESSO!')
    end

    it 'and needs to be logged in' do
        product = Product.create!(customer_name: 'Arthur', customer_address: 'Rua dos Anjos, 101',
        distance: 100, weight: 2000, height: 10, width: 20, depth: 5)

        visit(new_admin_product_order_path(product))

        expect(current_path).to eq new_admin_session_path
        expect(page). to have_content('Para continuar, faça login ou registre-se.')
    end
end