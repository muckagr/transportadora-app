require 'rails_helper'

describe 'Admin visits product page' do
    it 'and see theres no registered products' do
        admin = Admin.create(email: 'admin@sistemadefrete.com.br', password: 'password')

        login_as(admin, :scope => :admin)
        visit(root_path)
        click_on('Produtos')

        expect(page).to have_content('Não há produtos em espera')
    end

    it 'and see all products with status Esperando Ordem de Serviço' do
        admin = Admin.create(email: 'admin@sistemadefrete.com.br', password: 'password')
        product_1 = Product.create!(customer_name: 'Arthur', customer_address: 'Rua dos Anjos, 101',
                                    distance: 100, weight: 2000, height: 10, width: 20, depth: 5)
        product_2 = Product.create!(customer_name: 'Wesley', customer_address: 'Rua dos Demonios, 666',
                                    distance: 300, weight: 6000, height: 15, width: 10, depth: 10)

        login_as(admin, :scope => :admin)
        visit(root_path)
        click_on('Produtos')

        expect(page).to have_content("Pedido: ##{product_1.id}")
        expect(page).to have_content('Nome do Cliente: Arthur')
        expect(page).to have_content('Endereço de Entrega: Rua dos Anjos, 101')
        expect(page).to have_content("Pedido: ##{product_2.id}")
        expect(page).to have_content('Nome do Cliente: Wesley')
        expect(page).to have_content('Endereço de Entrega: Rua dos Demonios, 666')
    end
    
    it 'and needs to be logged in' do
        visit(admin_products_path)

        expect(current_path).to eq new_admin_session_path
        expect(page). to have_content('Para continuar, faça login ou registre-se.')
    end
end