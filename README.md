# TransportadoraApp

TranportadoraApp tem a finalidade de oferecer funcionalidades para transportadoras e seus clientes, sendo capaz de calcular preços, prazos e confirmar disponibilidade de frete.
O usuário Admin, além de outras responsabilidades, também tem a função de cadastrar Transportadoras que estejam interessadas em participar dessa associação. Assim que a Transportadora é cadastrada a mesma se torna apta a receber Ordens de Serviço ao preencher suas configurações de preços e prazos. As Ordens de Serviço são criadas também pelo Admin, e são compostas sempre por um produto, um prazo de entrega e o valor do frete. Cabe às Transportadoras decidirem aceitar ou não uma Ordem de Serviço. Quando uma ordem de serviço é aceita, o cliente então pode começar o rastreio do seu produto.

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
