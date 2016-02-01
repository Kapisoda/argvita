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

    if current_user == nil

    @no_user_articles.push(params[:format])
    else


    @shopping_cart = ShoppingCart.find_by(user_id: current_user.id)

    @carts_article = CartsArticle.find_by(shopping_cart_id: @shopping_cart.id, article_id: params[:format] )

    if @carts_article == nil
      CartsArticle.create(shopping_cart_id: @shopping_cart.id, article_id: params[:format], amount: 1 )
      @carts_article = CartsArticle.find_by(shopping_cart_id: @shopping_cart.id, article_id: params[:format] )
    else
      @carts_article.increment!(:amount)
    end
  end

    @article = Article.find(params[:format])
    #@carts_articles = CartsArticle.all



    if @article.on_discount.nil? || @article.on_discount == false || @article.discount != 0
      if current_user == nil
        @items_cost += @article.cost
        @items_cost.save
      else
        @shopping_cart.current_cost += @article.cost
        @shopping_cart.save
      end
    else
      if current_user == nil
        @items_cost += (@article.cost- (@article.cost*@article.discount/100))
        @items_cost.save
      end
        @shopping_cart.current_cost += (@article.cost- (@article.cost*@article.discount/100))
        @shopping_cart.save
    end

    redirect_to articles_index_path

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
