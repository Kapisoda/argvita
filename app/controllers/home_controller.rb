class HomeController < ApplicationController
  def index
    if user_signed_in?
       @cart = ShoppingCart.where(user_id: current_user.id)

      if @cart.empty?
        ShoppingCart.create(user_id: current_user.id)
       end
    end

    if params[:format] != nil
    @article = Article.find(params[:format])
    end

    @categories = Category.all
    @articles = Article.all

    if current_user != nil
    @shopping_cart = ShoppingCart.find_by(user_id: current_user.id)
    @carts_article = CartsArticle.find_by(shopping_cart_id: @shopping_cart.id )
    else
      @articles_no_user = Article.where(id: $no_user_articles.keys)
    end

  end



end
