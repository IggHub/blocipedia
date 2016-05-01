class ChargesController < ApplicationController
  def new
    @amount = 500
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Blocipedia - #{current_user.email}",
      amount: @amount
    }
  end

  def create
    # Creates a Stripe Customer object, for associating
    # with the charge
     @amount = 500

    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    # Where the real magic happens
    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- this is NOT the user_id in your app
      amount: @amount,
      description: "Premium Blocipedia User - #{current_user.email}",
      currency: 'usd'
    )

    flash[:notice] = "Thanks for the subscription, #{current_user.email}! Hope you enjoy your premium account!"
    redirect_to root_path # or wherever

    # Stripe will send back CardErrors, with friendly messages
    # when something goes wrong.
    # This `rescue block` catches and displays those errors.
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end
end
