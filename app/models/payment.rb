class Payment < ApplicationRecord
  belongs_to :order
  belongs_to :payment_method

  #from Carts Controller
  def self.create_paypal_payment(order_id, payment_code, order_total, token)
    create(
      order_id: order_id,
      payment_method_id: PaymentMethod.get_id_by_code(payment_code),
      state: "processing",
      total: order_total,
      token: token
    )
  end

  def self.complete_payment(response_token)
    payment = Payment.find_by(token: response_token)
    order = payment.order

    #update object states
    payment.state = "completed"
    order.state = "completed"

    ActiveRecord::Base.transaction do
      order.save!
      payment.save!
    end
  end
end
