require 'rails_helper'

describe 'Admin visits order of service page' do
    it 'and see registered orders of service' do
        admin = Admin.create!(email: 'admin@sistemadefrete.com.br', password: 'password')
        shipping_company = ShippingCompany.create!(email_domain: 'loja99.com', cnpj: '00000000000000', 
                corporate_name: '99 LTDA', brand_name: '99 CENTAVOS', full_adress: 'Rua dos Padres, 101',
                status: :active)
        product = Product.create!(customer_name: 'Arthur', customer_address: 'Rua dos Anjos, 101',
                distance: 100, weight: 2000, height: 10, width: 20, depth: 5)
        order = Order.create!(shipping_company: shipping_company, shipping_price: 75, delivery_time: 1)

        login_as(admin, :scope => :admin)
        visit(root_path)
        click_on('Ordens')

        expect(page).to have_content('99 CENTAVOS')
        expect(page).to have_content('Rua dos Anjos, 101')
    end

    it 'and see theres is no registered orders of service' do
        admin = Admin.create!(email: 'admin@sistemadefrete.com.br', password: 'password')

        login_as(admin, :scope => :admin)
        visit(root_path)
        click_on('Ordens')

        expect(page).to have_content('Não existem Ordens de Serviço')
    end

    it 'and needs to be logged in' do
        visit(admin_orders_path)

        expect(current_path).to eq new_admin_session_path
        expect(page). to have_content('Para continuar, faça login ou registre-se.')
    end
end