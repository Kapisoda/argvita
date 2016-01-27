class CartsArticlesController < ApplicationController
  before_action :authenticate_user!


  def index
  end

  def show
  end

  def new
    @carts_article = CartsArticle.new
  end

  
  def create
    @shopping_cart = ShoppingCart.find_by(user_id: current_user.id)
    CartsArticle.create(shopping_cart_id: @shopping_cart.id, article_id: params[:format])
    redirect_to articles_index_path
    #TODO sumu ukupnih proizvoda i da se carts article ne izraduje pri svakom odabiru artikla
  end



  def edit
  end

  def update
  end

  def destroy
  end
  private
  def cartsArticles_params
    params.require(:cartsArticles).permit(:id, :shopping_cart_id, :single_articles_id)
  end
end
