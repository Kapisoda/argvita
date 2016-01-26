class HomeController < ApplicationController
  def index
    if user_signed_in?
       @cart = ShoppingCart.where(user_id: current_user.id)

      if @cart.empty?
        ShoppingCart.create(user_id: current_user.id)
       end
    end
  end
end
