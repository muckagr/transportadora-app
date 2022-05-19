class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable  
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  before_validation :ensure_has_a_shipping_company
  belongs_to :shipping_company

  private
  def ensure_has_a_shipping_company
    user_domain = self.email.split('@').last
    if (ShippingCompany.where(email_domain: user_domain)).any?
      shipping_company = ShippingCompany.where(email_domain: user_domain).first
      self.shipping_company = shipping_company
    else
      errors.add(:shipping_company, 'inexistente')
    end
  end
end
