class ChargesController < ApplicationController
  def new
end

def create
  # Amount in cents
  @amount = 500

  Stripe::Charge.create(
    :amount      => @amount,
    :card        => params[:stripeToken],
    :description => 'Rails Stripe customer',
    :currency    => 'usd'
  )

rescue Stripe::CardError => e
  flash[:error] = e.message
  redirect_to :back
end

end
