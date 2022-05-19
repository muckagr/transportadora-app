require 'rails_helper'

describe 'Admin visits shipping company edit page' do
    it 'and see all admins editable shipping company fields' do
        admin = Admin.create(email: 'admin@admin.com.br', password: 'password')
        shipping_company = ShippingCompany.create!(email_domain: 'loja99.com', cnpj: '00000000000000', 
        corporate_name: '99 LTDA', brand_name: '99 CENTAVOS', full_adress: 'Rua dos Padres, 101')

        login_as(admin, :scope => :admin)
        visit(root_path)
        click_on('Transportadoras')
        click_on('99 CENTAVOS')
        click_on('Editar')

        expect(page).to have_field('Razão Social', with:'99 LTDA')
        expect(page).to have_field('Nome Fantasia', with: '99 CENTAVOS')
        expect(page).to have_field('CNPJ', with: '00000000000000')
        expect(page).to have_field('Domínio de E-mail', with: 'loja99.com')
        expect(page).to have_field('Endereço', with: 'Rua dos Padres, 101')
        expect(page).to have_field('Status', with: 'waiting')
    end

    it 'and sucessfully edits a shipping company' do
        admin = Admin.create(email: 'admin@admin.com.br', password: 'password')
        shipping_company = ShippingCompany.create!(email_domain: 'loja99.com', cnpj: '00000000000000', 
        corporate_name: '99 LTDA', brand_name: '99 CENTAVOS', full_adress: 'Rua dos Padres, 101')

        login_as(admin, :scope => :admin)
        visit(root_path)
        click_on('Transportadoras')
        click_on('99 CENTAVOS')
        click_on('Editar')
        fill_in('Razão Social', with: '999 LTDA')
        fill_in('CNPJ', with: '01020304050607')
        click_on('Editar')

        expect(page).to have_content('Transportadora atualizada com SUCESSO!')
        expect(page).to have_content('999 LTDA')
        expect(page).to have_content('99 CENTAVOS')
        expect(page).to have_content('01020304050607')
        expect(page).to have_content('loja99.com')
        expect(page).to have_content('Rua dos Padres, 101')
        expect(page).to have_content('waiting')
    end

    it 'and keeps all mandatory fields' do
        admin = Admin.create(email: 'admin@admin.com.br', password: 'password')
        shipping_company = ShippingCompany.create!(email_domain: 'loja99.com', cnpj: '00000000000000', 
        corporate_name: '99 LTDA', brand_name: '99 CENTAVOS', full_adress: 'Rua dos Padres, 101')

        login_as(admin, :scope => :admin)
        visit(root_path)
        click_on('Transportadoras')
        click_on('99 CENTAVOS')
        click_on('Editar')
        fill_in('Domínio de E-mail', with: '')
        fill_in('CNPJ', with: '')
        fill_in('Razão Social', with: '')
        fill_in('Nome Fantasia', with: '')
        fill_in('Endereço', with: '')
        click_on('Editar')

        expect(page).to have_content('Falha ao alterar informações')
        expect(page).to have_content('Domínio de E-mail não pode ficar em branco')
        expect(page).to have_content('CNPJ não pode ficar em branco')
        expect(page).to have_content('Razão Social não pode ficar em branc')
        expect(page).to have_content('Nome Fantasia não pode ficar em branco')
        expect(page).to have_content('Endereço não pode ficar em branco')
    end
end