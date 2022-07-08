require 'rails_helper'

describe 'Admin visits budget page' do
    it 'and sucessfully makes a budget' do
        admin = Admin.create!(email: 'admin@sistemadefrete.com.br', password: 'password')
        shipping_company_1 = ShippingCompany.create!(email_domain: 'loja99.com', cnpj: '00000000000000', 
                corporate_name: '99 LTDA', brand_name: '99 CENTAVOS', full_adress: 'Rua dos Padres, 101', minimal_price: 30,
                status: :active)
        shipping_company_2 = ShippingCompany.create!(email_domain: 'phoenix.com.br', cnpj: '13140158000128', 
                corporate_name: 'phoenix transp', brand_name: 'PHOENIX Transportadora', full_adress: 'Brasilia - SQS, 401', 
                price_km: 0.15, price_weight: 0.005, price_dimensions: 5, deadline_km: 1, minimal_price: 30, status: :active)

        login_as(admin, :scope => :admin)
        visit(root_path)
        click_on('Orçamento')
        fill_in('Altura', with: '15')
        fill_in('Largura', with: '55')
        fill_in('Profundidade', with: '10')
        fill_in('Peso', with: '5000')
        fill_in('Distância', with: '100')
        click_on('Consultar Preço')

        expect(page).to have_content('Orçamento gerado com SUCESSO!')
        expect(page).to have_content("#{shipping_company_1.brand_name}")
        expect(page).to have_content("R$")
        expect(page).to have_content('dias úteis')
        expect(page).to have_content("#{shipping_company_2.brand_name}")
        expect(page).to have_content("R$")
        expect(page).to have_content('dias úteis')
    end

    it 'and unsucessfully makes a budget' do
        admin = Admin.create!(email: 'admin@sistemadefrete.com.br', password: 'password')
        shipping_company_1 = ShippingCompany.create!(email_domain: 'anjo.com.br', cnpj: '13140122000128', 
                corporate_name: 'ANJO SKY', brand_name: 'Anjo Transportadora', full_adress: 'São Paulo - SQS, 401', 
                price_km: 0.25, price_weight: 0.008, price_dimensions: 3, deadline_km: 1, minimal_price: 60, status: :active)
        shipping_company_2 = ShippingCompany.create!(email_domain: 'phoenix.com.br', cnpj: '13140158000128', 
                corporate_name: 'phoenix transp', brand_name: 'PHOENIX Transportadora', full_adress: 'Brasilia - SQS, 401', 
                price_km: 0.15, price_weight: 0.005, price_dimensions: 5, deadline_km: 2, minimal_price: 30, status: :active)

        login_as(admin, :scope => :admin)
        visit(root_path)
        click_on('Orçamento')
        fill_in('Altura', with: 'a')
        fill_in('Largura', with: '-1')
        fill_in('Profundidade', with: '')
        click_on('Consultar Preço')

        expect(page).to have_content('Falha ao realizar orçamento')
        expect(page).to have_content('Altura não é um número')
        expect(page).to have_content('Largura deve ser maior que 0')
        expect(page).to have_content('Profundidade não pode ficar em branco')
    end

    it 'and needs to be logged in' do
        visit(new_admin_budget_generate_path)

        expect(current_path).to eq new_admin_session_path
        expect(page). to have_content('Para continuar, faça login ou registre-se.')
    end
end