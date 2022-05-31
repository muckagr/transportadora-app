# TransportadoraApp

A TransportadoraApp tem a finalidade de oferecer funcionalidades para transportadoras e seus clientes, sendo capaz de calcular preços, prazos, confirmar disponibilidade de frete e rastrear pedidos.
O usuário Administrador (Admin), tem a função de cadastrar Transportadoras que estejam interessadas em participar dessa associação, além de outras responsabilidades. Assim que a Transportadora é cadastrada, é possível realizar o cadastro de funcionários, bastando apenas a criar a conta informando o domínio de e-mail de sua respectiva Transportadora.
Os funcionários tem permissão de alterar configurações de preços e prazos de suas empresas, assim, tornando-as aptas a receber Ordens de Serviço.
Ordens de Serviço são criadas também pelo Admin e são compostas sempre por um produto, um prazo de entrega e o valor do frete. Cabe às Transportadoras decidirem aceitar ou não uma Ordem de Serviço. Quando uma ordem de serviço é aceita, o cliente então pode começar o rastreio do seu produto pelo código da ordem de serviço.

## Requisitos

- ruby "3.0.3"

## Dependências

### Testes

- gem 'rspec-rails (5.1.2)'
- gem "capybara (3.36.0)"
- gem 'shoulda-matchers', '~> 5.0'

### Autorização/Autenticação

- gem 'devise'

## Como executar essa aplicação?

#### 1. Clonar o projeto a partir de seu terminal

        git clone https://github.com/muckagr/transportadora-app.git

#### 2. Entrar no diretório da Aplicação

            cd transportadora-app

#### 3. Instalar todas as dependências necessárias

            bin/setup

#### 4. Popular o banco de dados

           rails db:seed

#### 5. Iniciar a aplicação

            rails s

#### 6. Acessar pelo seu navegador

            http://localhost:3000/

## Dados Pré-Existentes

1.  Conta de Administrador (Admin)

    - email: arthurafk@sistemadefrete.com.br, password: password

2.  Conta de Funcionário (User)

    - email: arthur@sedex.com.br, password: password

    - email: arthur@phoenix.com.br, password: password

    - email: arthur@papaleguas.com.br, password: password

3.  Transportadoras

    - SEDEX
    - PHOENIX Transportadora
    - Papaléguas Transportadora

4.  Outros
    -03 veículos e 03 produtos
