class PastPurchasesController < ApplicationController
  def index
  end

  def show

  end

  def create

     @shopping_cart = ShoppingCart.find_by(user_id: current_user.id)

     @user = User.find_by(id: current_user.id)

     @user.purchase_sum += @shopping_cart.current_cost
     @user.save
     @shopping_cart.current_cost = 0
     @shopping_cart.save

     @shopping_cart.articles.each do |art|
       @past_purchase = PastPurchase.find_by(article_id: art.id)
       if @past_purchase != nil
         @past_purchase.increment!(:amount)

       else
         PastPurchase.create(user_id: current_user.id, article_id: art.id, article_sent: false, cost: art.cost )

       end

     end
     #@past_purchase.cost = @shopping_cart.current_cost

     #@user = User.find_by(id: current_user.id)
    # @user.purchase_sum += @shopping_cart.current_cost


     CartsArticle.destroy_all(shopping_cart_id: @shopping_cart.id)


    redirect_to articles_index_path

  end

  def edit
  end

  def update
  end

  def destroy
  end
end
