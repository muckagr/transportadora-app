require 'rails_helper'

describe 'User visits shipping company edit page' do
    it 'and see all users editable shipping company fields' do
        shipping_company = ShippingCompany.create!(email_domain: 'loja99.com', cnpj: '00000000000000', 
        corporate_name: '99 LTDA', brand_name: '99 CENTAVOS', full_adress: 'Rua dos Padres, 101')
        user = User.create(email: 'user@loja99.com', password: 'password')

        login_as(user, :scope => :user)
        visit(root_path)
        click_on('Transportadora')
        click_on('Editar')

        expect(page).to have_field('Preço por m3', with:'0.0')
        expect(page).to have_field('Preço por km', with: '0.0')
        expect(page).to have_field('Preço por grama', with: '0.0')
        expect(page).to have_field('Dias úteis de prazo/30km', with: '0')
    end

    it 'and sucessfully edits a shipping company' do
        shipping_company = ShippingCompany.create!(email_domain: 'loja99.com', cnpj: '00000000000000', 
        corporate_name: '99 LTDA', brand_name: '99 CENTAVOS', full_adress: 'Rua dos Padres, 101')
        user = User.create(email: 'user@loja99.com', password: 'password')

        login_as(user, :scope => :user)
        visit(root_path)
        click_on('Transportadora')
        click_on('Editar')
        fill_in('Preço por m3', with: '5.0')
        fill_in('Preço por km', with: '0.15')
        fill_in('Preço por grama', with: '0.005')
        fill_in('Dias úteis de prazo/30km', with: '1')
        click_on('Editar')

        expect(page).to have_content('Transportadora atualizada com SUCESSO!')
        expect(page).to have_content('Preço por grama: 0.005')
        expect(page).to have_content('Preço por m3: 5.0')
        expect(page).to have_content('Preço por km: 0.15')
        expect(page).to have_content('Dias úteis de prazo/30km: 1')
    end

    it 'and keeps all mandatory fields' do
        shipping_company = ShippingCompany.create!(email_domain: 'loja99.com', cnpj: '00000000000000', 
        corporate_name: '99 LTDA', brand_name: '99 CENTAVOS', full_adress: 'Rua dos Padres, 101')
        user = User.create(email: 'user@loja99.com', password: 'password')

        login_as(user, :scope => :user)
        visit(root_path)
        click_on('Transportadora')
        click_on('Editar')
        fill_in('Preço por m3', with: '-1')
        fill_in('Preço por km', with: 'a')
        fill_in('Preço por grama', with: '')
        fill_in('Dias úteis de prazo/30km', with: '1.2')
        click_on('Editar')

        expect(page).to have_content('Falha ao atualizar Transportadora')
        expect(page).to have_content('Preço por m3 deve ser maior ou igual a 0')
        expect(page).to have_content('Preço por grama não pode ficar em branco')
        expect(page).to have_content('Preço por km não é um número')
        expect(page).to have_content('Dias úteis de prazo/30km não é um número inteiro')
    end
end