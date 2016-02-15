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

    if current_user == nil  # kad nema usera #############################################################################################




      puts "Ispred if za provjeru jel se artikl nalazi u hash-u"
      if $no_user_articles.has_key?(@article.id.to_s)
        $no_user_articles.each do |k, v|
          if k == @article.id.to_s
            $no_user_articles[k] += 1

          end
        end
      else
        puts "Unutar if-else-a kada nije pronaden artikl unutar hash-a"
        $no_user_articles[params[:format]] = 1

      end



    else   # kad ima usera ################################################################################################################

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

    if current_user != nil  #kad ima usera #############################################################################################################################
    @shopping_cart = ShoppingCart.find_by(user_id: current_user.id)
    end

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

      if current_user != nil
      CartsArticle.create(single_article_id: @sa.id, shopping_cart_id: @shopping_cart.id, amount: params[:article][:amount])
      end

    else

      if current_user != nil
      CartsArticle.create(article_id: params[:article][:id], shopping_cart_id: @shopping_cart.id, amount: params[:article][:amount] )
      end
    end

    if current_user != nil
    @shopping_cart.current_cost += prize
    @shopping_cart.save
    end




    if current_user == nil # dodaje single article u hash single article ##############################################################
      if @sa != nil
        puts "single article nije nil"
        if $no_user_single_articles.has_key?(@sa.id.to_s)
          puts "nasao je taj key od single article-a"
          $no_user_single_articles.each do |k, v|
            if k == @sa.id.to_s
              $no_user_single_articles[k] += 1
              puts "nasao je da postoji vec u varijabli"
            end
          end
    else
      puts "Unutar if-else-a kada nije pronaden artikl unutar hash-a"
      $no_user_single_articles[@sa.id] = 1
    end
    $items_cost+=prize
    end
    end

    $no_user_single_articles.each do |k,v|
      puts "#{k}"
    end
############################################################################################################################################


    redirect_to trgovina_index_path
  end



  def create_single

    puts "USAO SAM U CREATE SINGLE"

    @single_article = SingleArticle.find(params[:format])


    if current_user != nil  # kad ima usera #############################################################################################

    @shopping_cart = ShoppingCart.find_by(user_id: current_user.id)

    @carts_article = CartsArticle.find_by(shopping_cart_id: @shopping_cart.id, single_article_id: params[:format] )

    if @carts_article.amount < @single_article.amount
      @carts_article.increment!(:amount)
    end

    else  #kad nema usera   ################################################################################################################


      if $no_user_articles.has_key?(@single_article.id.to_s)
        $no_user_articles.each do |k, v|
          if k == @article.id.to_s
            $no_user_articles[k] += 1
          end
        end
      else
        $no_user_articles[params[:format]] = 1
      end




    end  ###################################################################################################################################

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



  def plus_no_user

    @no_articles = Article.where(id: $no_user_articles.keys)
    @sa = SingleArticle.where(id: $no_user_single_articles.keys)

    puts "uso plus _no user"


    art = SingleArticle.find_by(id: params[:format])

    if art.article.on_discount != nil && art.article.on_discount == true
      prize = (art.article.cost- (art.article.cost*art.article.discount/100))
    else
      prize = art.article.cost
    end



        puts "uso u has key?"
       $no_user_single_articles.each do |k, v|
         puts "uso u no user articles petlju"
         if k == art.id
           puts "uso u if provjeru"
          $no_user_single_articles[k] += 1
          $items_cost+=prize
         end
          end


    redirect_to :back
  end

  def min_no_user

    @articles = Article.where(id: $no_user_articles.keys)
    @sa = SingleArticle.where(id: $no_user_single_articles.keys)

    puts "uso plus _no user"


    art = SingleArticle.find_by(id: params[:format])

    if art.article.on_discount != nil && art.article.on_discount == true
      prize = (art.article.cost- (art.article.cost*art.article.discount/100))
    else
      prize = art.article.cost
    end



    puts "uso u has key?"
    $no_user_single_articles.each do |k, v|
      puts "uso u no user articles petlju"
      if k == art.id
        if v > 1
        puts "uso u if provjeru"
        $no_user_single_articles[k] -= 1
        $items_cost-=prize
        else
          $no_user_single_articles.delete(k)
          $items_cost-=prize
        end
      end
    end


    redirect_to :back



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
