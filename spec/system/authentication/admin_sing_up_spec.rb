require 'rails_helper'

describe 'guest visits admin sign up' do
    it 'and registers uncessfully' do

        visit(root_path)
        click_on('Login como Admin')
        click_on('Sign up')
        fill_in('E-mail', with: 'chaves@sbt.com.br')
        fill_in('Senha', with: 'password')
        fill_in('Confirme sua senha', with: 'password')
        click_on('Sign up')

        expect(page).to have_content('Erro ao cadastrar Administrador!')
        expect(page).not_to have_content('Você criou sua conta com SUCESSO!')
    end
end