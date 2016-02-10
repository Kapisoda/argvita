class ShoppingCartsController < ApplicationController
 # before_action :authenticate_user!
  def index


  end

  def show
    if current_user == nil
      #$no_user_articles.each do |k, v|
        @articles = Article.where(id: $no_user_articles.keys)



    else
    @shopping_cart = ShoppingCart.find_by(user_id: current_user.id)
    @carts_article = CartsArticle.find_by(shopping_cart_id: @shopping_cart.id )
    end





  end

  def new

  end

  def create
    if current_user == nil

      @article = Article.find(params[:format])


      puts "Ispred if za provjeru jel se artikl nalazi u hash-u"
      if $no_user_articles.has_key?(@article.id.to_s)
        $no_user_articles.each do |k, v|
          if k == @article.id.to_s
            $no_user_articles[k] += 1
            $items_cost +=@article.cost
          end
        end
      else
        puts "Unutar if-else-a kada nije pronaden artikl unutar hash-a"
        $no_user_articles[params[:format]] = 1
        $items_cost +=@article.cost
      end



    else


      @shopping_cart = ShoppingCart.find_by(user_id: current_user.id)

      @carts_article = CartsArticle.find_by(shopping_cart_id: @shopping_cart.id, article_id: params[:format] )

      if @carts_article == nil
        CartsArticle.create(shopping_cart_id: @shopping_cart.id, article_id: params[:format], amount: 1 )
        @carts_article = CartsArticle.find_by(shopping_cart_id: @shopping_cart.id, article_id: params[:format] )
      else
        @carts_article.increment!(:amount)
      end



      @article = Article.find(params[:format])
      #@carts_articles = CartsArticle.all



      if @article.on_discount.nil? || @article.on_discount == false || @article.discount != 0
        if current_user == nil

          $items_cost += @article.cost

        else
          @shopping_cart.current_cost += @article.cost
          @shopping_cart.save
        end
      else
        if current_user == nil

          $items_cost += (@article.cost- (@article.cost*@article.discount/100))

        end
        @shopping_cart.current_cost += (@article.cost- (@article.cost*@article.discount/100))
        @shopping_cart.save
      end




    end



    redirect_to shopping_carts_show_path

  end

  def edit
  end

  def update

  end

  def destroy
    @article = Article.find(params[:format])

    if current_user == nil

      if $no_user_articles.has_key?(@article.id.to_s)

        $no_user_articles.each do |k, v|

          if k == @article.id.to_s && v.to_i > 1
            puts "ulazi u if"
            $no_user_articles[k] -= 1
            if @article.on_discount.nil? || @article.on_discount == false || @article.discount != 0
              $items_cost -= @article.cost

            else
              $items_cost -= (@article.cost- (@article.cost*@article.discount/100))

            end
          end

          if k == @article.id.to_s && v.to_i == 1
            puts "ulazi u else"
            if @article.on_discount.nil? || @article.on_discount == false || @article.discount != 0
              $items_cost -= @article.cost

            else
              $items_cost -= (@article.cost- (@article.cost*@article.discount/100))

            end
            $no_user_articles.delete(k)
          end

        end
      end

    else

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

    redirect_to :back
  end




  private
  def cart_params
    params.require(:cart).permit(:id, :user_id, :current_cost)
  end


end
