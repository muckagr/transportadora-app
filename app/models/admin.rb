class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  before_validation :ensure_is_valid_domain

  private
  #resource.errors.messages[:shipping_company]
  def ensure_is_valid_domain
    return unless email.present?
    input_domain = self.email.split('@').last
    if input_domain != 'sistemadefrete.com.br'
      errors.add(:shipping_company, 'Erro ao cadastrar Administrador!')
    end
  end
end
