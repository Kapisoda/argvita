class ShoppingCartsController < ApplicationController
  before_action :authenticate_user!
  def index


  end

  def show
    if current_user == nil
      @art= Article.where(id: @no_user_articles)
    else
    @shopping_cart = ShoppingCart.find_by(user_id: current_user.id)
    end
    #@carts_articles = CartsArticle.where(shopping_cart_id: @shopping_cart.id )




  end

  def new

  end

  def create

  end

  def edit
  end

  def update
  end

  def destroy

    if current_user == nil

      @no_user_articles.delete(params[:format])


    else
      @article = Article.find(params[:format])
    @shopping_cart = ShoppingCart.find_by(user_id: current_user.id)
    @carts_article = CartsArticle.find_by(shopping_cart_id: @shopping_cart.id, article_id: params[:format] )
    if @carts_article.amount > 1
      @carts_article.amount -= 1
      @carts_article.save
      if @article.on_discount.nil? || @article.on_discount == false || @article.discount != 0
        @shopping_cart.current_cost -= @article.cost
        @shopping_cart.save
      else
        @shopping_cart.current_cost -= (@article.cost- (@article.cost*@article.discount/100))
        @shopping_cart.save
      end
    else
      if @article.on_discount.nil? || @article.on_discount == false || @article.discount != 0
        @shopping_cart.current_cost -= @article.cost
        @shopping_cart.save
      else
        @shopping_cart.current_cost -= (@article.cost- (@article.cost*@article.discount/100))
        @shopping_cart.save
      end
      @carts_article.destroy!
    end
    end

    redirect_to shopping_carts_show_path
  end




  private
  def cart_params
    params.require(:cart).permit(:id, :user_id, :current_cost)
  end


end