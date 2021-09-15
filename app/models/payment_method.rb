class PaymentMethod < ApplicationRecord
  has_many :payments, dependent: :destroy

  #From Carts Controller
  def self.get_id_by_code(code)
    find_by(code: code).id
  end
end
