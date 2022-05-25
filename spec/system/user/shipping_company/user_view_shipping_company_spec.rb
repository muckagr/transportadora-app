require 'rails_helper'

describe 'User visits his shipping company page' do
    it 'and see all his shipping company details' do
        shipping_company = ShippingCompany.create!(email_domain: 'loja99.com', cnpj: '00000000000000', 
        corporate_name: '99 LTDA', brand_name: '99 CENTAVOS', full_adress: 'Rua dos Padres, 101')
        shipping_company_2 = ShippingCompany.create!(email_domain: 'loja1000.com', cnpj: '00000000002000', 
        corporate_name: '1000 LTDA', brand_name: '1000 REAIS', full_adress: 'Rua dos Padres, 101')
        user = User.create(email: 'user@loja99.com', password: 'password')
        user2 = User.create(email: 'user@loja100.com', password: 'password')

        login_as(user, :scope => :user)
        visit(root_path)
        click_on('Transportadora')

        expect(page).to have_content('Nome Fantasia: 99 CENTAVOS')
        expect(page).to have_content('Domínio de E-mail: loja99.com')
        expect(page).to have_content('Razão Social: 99 LTDA')
        expect(page).to have_content('Endereço: Rua dos Padres, 101')
        expect(page).to have_content('Preço por km:')
        expect(page).to have_content('Preço por grama:')
        expect(page).to have_content('Preço por m3:')
        expect(page).to have_content('Dias úteis de prazo/30km:')
        expect(page).to have_content('Preço mínimo')
        expect(page).to have_content('Status: waiting')
        expect(page).not_to have_content('1000 REAIS')
    end
end