class CartsController < ApplicationController
  before_action :authenticate_user!

  def update
    current_order.add_product(params[:cart][:product_id], params[:cart][:quantity], params[:cart][:variation_id])

    redirect_to root_url, notice: "Product added successfuly"
  end

  def show
    @order = current_order
  end

  def pay_with_paypal
    order_id = params[:cart][:order_id]
    order_total = Order.get_order_total(order_id)
    token = get_response_token(order_total)

    Payment.create_paypal_payment(order_id, "PEC", order_total, token)

    redirect_to EXPRESS_GATEWAY.redirect_url_for(token)
  end

  def process_paypal_payment
    token = params[:token]
    details = EXPRESS_GATEWAY.details_for(token)
    response = EXPRESS_GATEWAY.purchase(usd_in_cents(details.params["order_total"].to_d), set_purchase_options(token, "USD"), details.payer_id)

    if response.success?
      Payment.complete_payment(response.token)
    end
  end
end
