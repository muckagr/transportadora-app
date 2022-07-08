require 'rails_helper'

describe 'guest visits admin sign up' do
    it 'and registers uncessfully' do

        visit(root_path)
        click_on('Administrador')
        click_on('Registrar')
        fill_in('E-mail', with: 'chaves@sbt.com.br')
        fill_in('Senha', with: 'password')
        fill_in('Confirme sua senha', with: 'password')
        click_on('Registrar')

        expect(page).to have_content('Erro ao cadastrar Administrador!')
        expect(page).not_to have_content('Você criou sua conta com SUCESSO!')
    end
    it 'and registers sucessfully' do

        visit(root_path)
        click_on('Administrador')
        click_on('Registrar')
        fill_in('E-mail', with: 'chaves@sistemadefrete.com.br')
        fill_in('Senha', with: 'password')
        fill_in('Confirme sua senha', with: 'password')
        click_on('Registrar')

        expect(page).to have_content('Boas vindas! Você criou sua conta com SUCESSO!')
        expect(page).not_to have_content('Erro ao cadastrar Administrador!')
    end
end