class CartsArticlesController < ApplicationController
  #before_action :authenticate_user!


  def index
  end

  def show
  end

  def new
    @carts_article = CartsArticle.new
  end


  def create

    @article = Article.find(params[:format])

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
      elsif @carts_article.amount < @article.amount
        @carts_article.increment!(:amount)
      end

    end




    if @article.on_discount.nil? || @article.on_discount == false || @article.discount != 0
      if current_user == nil

        $items_cost += @article.cost

      end

      if current_user != nil
        if @carts_article.amount < @article.amount
           @shopping_cart.current_cost += @article.cost
           @shopping_cart.save
        else
          flash[:error] = "Nema dovoljne kolicine artikla u ducanu"

        end
      end


    else
      if current_user == nil

        $items_cost += (@article.cost- (@article.cost*@article.discount/100))

      end
        @shopping_cart.current_cost += (@article.cost- (@article.cost*@article.discount/100))
        @shopping_cart.save
    end

    redirect_to :back

  end

  def single
    @shopping_cart = ShoppingCart.find_by(user_id: current_user.id)
    art = Article.find_by(id: params[:article][:id])

    if art.on_discount != nil && art.on_discount == true
      prize = (art.cost- (art.cost*art.discount/100))
    else
      prize = art.cost
    end

    if params[:article][:color] || params[:article][:size]

      puts "Usao sam u single_article carts_article"

      if params[:article][:size]

        puts "Usao sam u size"

        @sa = SingleArticle.where(article_id: params[:article][:id],size: params[:article][:size] )
      elsif params[:article][:color]

        puts "Usao sam u color"

        @sa = SingleArticle.find_by("article_id = ? AND color_id = ?", params[:article][:id], params[:article][:color])
      end

      puts "ID od single article-a je #{@sa.id}"

      CartsArticle.create(single_article_id: @sa.id, shopping_cart_id: @shopping_cart.id, amount: params[:article][:amount])

    else

      CartsArticle.create(article_id: params[:article][:id], shopping_cart_id: @shopping_cart.id, amount: params[:article][:amount] )

    end

    @shopping_cart.current_cost += prize
    @shopping_cart.save

    redirect_to trgovina_index_path
  end



  def create_single

    puts "USAO SAM U CREATE SINGLE"

    @single_article = SingleArticle.find(params[:format])

    @shopping_cart = ShoppingCart.find_by(user_id: current_user.id)

    @carts_article = CartsArticle.find_by(shopping_cart_id: @shopping_cart.id, single_article_id: params[:format] )

    if @carts_article.amount < @single_article.amount
      @carts_article.increment!(:amount)
    end


    if @single_article.article.on_discount.nil? || @single_article.article.on_discount == false || @single_article.article.discount != 0
      if current_user == nil

        $items_cost += @single_article.article.cost

      end

      if current_user != nil
        if @carts_article.amount < @single_article.article.amount
          @shopping_cart.current_cost += @single_article.article.cost
          @shopping_cart.save
        else
          flash[:error] = "Nema dovoljne kolicine artikla u ducanu"

        end
      end


    else
      if current_user == nil

        $items_cost += (@single_article.article.cost- (@single_article.article.cost*@single_article.article.discount/100))

      end
      @shopping_cart.current_cost += (@single_article.article.cost- (@single_article.article.cost*@single_article.article.discount/100))
      @shopping_cart.save
    end



    redirect_to shopping_carts_show_path


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
