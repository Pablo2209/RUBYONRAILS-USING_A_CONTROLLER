class ApplicationController < ActionController::Base

  def current_order
    if current_user
      order = Order.where(user_id: current_user.id).where(state: "created").last
      if order.nil?
        order = Order.create!(user: current_user, state: "created")
      end
      return order
    end

    nil
  end

  #From Carts Controller
  def usd_in_cents (price)
    price * 100
  end

  def get_response_token(order_total)
    EXPRESS_GATEWAY.setup_purchase(usd_in_cents(order_total),
      ip: request.remote_ip,
      return_url: process_paypal_payment_cart_url,
      cancel_return_url: root_url,
      allow_guest_checkout: true,
      currency: "USD").token
  end

  def set_purchase_options(token, currency, payer_id)
    express_purchase_options =
      {
        ip: request.remote_ip,
        token: token,
        payer_id: payer_id,
        currency: currency
      }
  end

end
