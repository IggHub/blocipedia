class ChargesController < ApplicationController
  def new
    @amount = 500
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Blocipedia - #{current_user.username}",
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
      description: "Premium Blocipedia User - #{current_user.username}",
      currency: 'usd'
    )

    flash[:notice] = "Thanks for the subscription, #{current_user.username}! Hope you enjoy your premium account!"
    current_user.update_attribute(:role, 1)
    redirect_to wikis_path # or wherever

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end


    def downgrade
      current_user.update_attribute(:role, 0)
      flash[:notice] = "We are sorry to downgrade you, #{current_user.username} - hope you enjoy being mediocre!"
      redirect_to wikis_path
    end

end
