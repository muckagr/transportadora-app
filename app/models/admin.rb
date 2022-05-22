class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  before_validation :ensure_is_valid_domain

  private
  def ensure_is_valid_domain
    input_domain = self.email.split('@').last
    if input_domain != 'sistemadefrete.com.br'
      errors.add(:base, 'Erro ao cadastrar Administrador!')
    end
  end
end
