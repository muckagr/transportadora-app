class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable  
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  before_validation :ensure_has_a_shipping_company
  belongs_to :shipping_company

  private
  def ensure_has_a_shipping_company
    return unless email.present?
    input_domain = self.email.split('@').last
    unless ShippingCompany.find_by(email_domain: input_domain).nil?
      shipping_company = ShippingCompany.find_by(email_domain: input_domain)
      self.shipping_company = shipping_company
    else
      errors.add(:base, 'Erro ao cadastrar, domínio inválido!')
    end
  end
end
