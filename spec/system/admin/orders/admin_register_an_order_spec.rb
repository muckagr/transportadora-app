require 'rails_helper'

describe 'Admin clicks on create a service order from a product' do
    it 'and gets redirected to the create order of service page' do
        admin = Admin.create!(email: 'admin@sistemadefrete.com.br', password: 'password')
        product = Product.create!(customer_name: 'Arthur', customer_address: 'Rua dos Anjos, 101',
                distance: 100, weight: 2000, height: 10, width: 20, depth: 5)
        shipping_company = ShippingCompany.create!(email_domain: 'loja99.com', cnpj: '00000000000000', 
                corporate_name: '99 LTDA', brand_name: '99 CENTAVOS', full_adress: 'Rua dos Padres, 101',
                status: :accepted)
        
        login_as(admin, :scope => :admin)
        visit(root_path)
        click_on('Produtos')
        click_on('Gerar Ordem de Serviço')

        expect(current_path).to eq new_admin_product_order_path(product)
    end

    it 'and sees all product informations' do
        admin = Admin.create!(email: 'admin@sistemadefrete.com.br', password: 'password')
        product = Product.create!(customer_name: 'Arthur', customer_address: 'Rua dos Anjos, 101',
                distance: 100, weight: 2000, height: 10, width: 20, depth: 5)
        shipping_company = ShippingCompany.create!(email_domain: 'loja99.com', cnpj: '00000000000000', 
                corporate_name: '99 LTDA', brand_name: '99 CENTAVOS', full_adress: 'Rua dos Padres, 101',
                status: :accepted)
        
        login_as(admin, :scope => :admin)
        visit(root_path)
        click_on('Produtos')
        click_on('Gerar Ordem de Serviço')

        expect(page).to have_content('Peso: 2000g')
        expect(page).to have_content('Altura: 10cm')
        expect(page).to have_content('Largura: 20cm')
        expect(page).to have_content('Profundidade: 5cm')
        expect(page).to have_content('Endereço de Entrega: Rua dos Anjos, 101')
        expect(page).to have_content('Distância: 100km')
    end

    it 'and sees shipping prices for shipping companies that are active' do
        admin = Admin.create!(email: 'admin@sistemadefrete.com.br', password: 'password')
        product = Product.create!(customer_name: 'Arthur', customer_address: 'Rua dos Anjos, 101',
                distance: 100, weight: 2000, height: 10, width: 20, depth: 5)
        shipping_company = ShippingCompany.create!(email_domain: 'loja99.com', cnpj: '00000000000000', 
                corporate_name: '99 LTDA', brand_name: '99 CENTAVOS', full_adress: 'Rua dos Padres, 101',
                status: :active)
        shipping_company_2 = ShippingCompany.create!(email_domain: 'phoenix.com.br', cnpj: '13140158000128', 
        corporate_name: 'phoenix transp', brand_name: 'PHOENIX Transportadora', full_adress: 'Brasilia - SQS, 401', 
                price_km: 0.15, price_weight: 0.005, price_dimensions: 5, deadline_km: 1)
        
        login_as(admin, :scope => :admin)
        visit(root_path)
        click_on('Produtos')
        click_on('Gerar Ordem de Serviço')

        expect(page).to have_content('R$')
        expect(page).to have_content('99 CENTAVOS')
        expect(page).not_to have_content('PHOENIX Transportadora')
    end

    it 'and register an order of service sucessfully' do
        admin = Admin.create!(email: 'admin@sistemadefrete.com.br', password: 'password')
        product = Product.create!(customer_name: 'Arthur', customer_address: 'Rua dos Anjos, 101',
                distance: 100, weight: 2000, height: 10, width: 20, depth: 5)
        shipping_company = ShippingCompany.create!(email_domain: 'loja99.com', cnpj: '00000000000000', 
                corporate_name: '99 LTDA', brand_name: '99 CENTAVOS', full_adress: 'Rua dos Padres, 101',
                status: :active)
        shipping_company_2 = ShippingCompany.create!(email_domain: 'phoenix.com.br', cnpj: '13140158000128', 
                corporate_name: 'phoenix transp', brand_name: 'PHOENIX Transportadora', full_adress: 'Brasilia - SQS, 401', 
                price_km: 0.15, price_weight: 0.005, price_dimensions: 5, deadline_km: 1, status: :active)

        login_as(admin, :scope => :admin)
        visit(root_path)
        click_on('Produtos')
        click_on('Gerar Ordem de Serviço')
        find(:id, "#{shipping_company.id}").choose()
        click_on('Gerar Ordem de Serviço')

        expect(page).to have_content('Ordem de Serviço gerada com SUCESSO!')
    end

    it 'and needs to be logged in' do
        product = Product.create!(customer_name: 'Arthur', customer_address: 'Rua dos Anjos, 101',
                distance: 100, weight: 2000, height: 10, width: 20, depth: 5)

        visit(new_admin_product_order_path(product))

        expect(current_path).to eq new_admin_session_path
        expect(page). to have_content('Para continuar, faça login ou registre-se.')
    end
end