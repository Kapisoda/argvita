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

    @carts_article = CartsArticle.find_by(shopping_cart_id: @shopping_cart.id, article_id: params[:format] )

    if @carts_article == nil
      CartsArticle.create(shopping_cart_id: @shopping_cart.id, article_id: params[:format] )
      @carts_article = CartsArticle.find_by(shopping_cart_id: @shopping_cart.id, article_id: params[:format] )
      @carts_article.increment!(:amount)
    else
      @carts_article.increment!(:amount)
    end



    redirect_to articles_index_path




    # @article= Article.find_by(params[:format])
   # if @user.shopping_cart.carts_article == nil
   # @carts_article = CartsArticle.create(shopping_cart_id: @shopping_cart.id, article_id: params[:format] )
   # redirect_to articles_index_path
   # if @carts_article.article.id == params[:format]
   #   @carts_article.amount += 1
   # else


    #@shopping_cart.current_cost = CartsArticle.article.count(:cost)


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
    params.require(:cartsArticles).permit(:id, :shopping_cart_id, :single_articles_id, :amount)
  end
end
