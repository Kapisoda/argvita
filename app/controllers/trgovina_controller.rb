class TrgovinaController < ApplicationController

  def categories
    if current_user == nil
      @no_articles = Article.where(id: $no_user_articles.keys)
      @sa = SingleArticle.where(id: $no_user_single_articles.keys)

    else
      @shopping_cart = ShoppingCart.find_by(user_id: current_user.id)
      @carts_article = CartsArticle.find_by(shopping_cart_id: @shopping_cart.id )

    end


    ########################################################## dodan za search ###########################################################
    @page_title = "Artikli"
    @filterrific = initialize_filterrific(Material.all, params[:filterrific]) or return
    @materials = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end

  rescue ActiveRecord::RecordNotFound => e
    # There is an issue with the persisted param_set. Reset it.
    puts "Had to reset filterrific params: #{ e.message }"
    redirect_to(reset_filterrific_url(format: :html)) and return
    ############################################################################################################################################

  end

  def index_of
    @categories = Category.where(id: CategoryMaterial.where(material_id: params[:id]).pluck(:category_id) )
    @materials = Material.all

    puts "Usao je u trgovina#index"

    if current_user != nil
      @shopping_cart = ShoppingCart.find_by(user_id: current_user.id)

      puts "Shopping cart ID: #{@shopping_cart.id}"

      @carts_article = CartsArticle.find_by(shopping_cart_id: @shopping_cart.id )
    else
      puts "NEMA USER-A!!!!"




      @no_articles = Article.where(id: $no_user_articles.keys)
      @sa = SingleArticle.where(id: $no_user_single_articles.keys)
    end

    if params[:id] != nil
      $material_id = params[:id]
    end
    # filterific ###########################################################################################################################
    @page_title = "Artikli"
    @filterrific = initialize_filterrific(Article.where(raw: false, for_sale: true, material_id: $material_id ), params[:filterrific], select_options: { sorted_by: Article.options_for_sorted_by,
                                                                                                                                                       with_category_id: Category.options_for_select,
                                                                                                                                                       with_material_id: Material.options_for_select}) or return



    @articles = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end


  rescue ActiveRecord::RecordNotFound => e
    # There is an issue with the persisted param_set. Reset it.
    puts "Had to reset filterrific params: #{ e.message }"
    redirect_to(reset_filterrific_url(format: :html)) and return

    ###########################################################################################################################

  end

  def index
    @categories = Category.all
    @materials = Material.all

    puts "Usao je u trgovina#index"

    if current_user != nil
      @shopping_cart = ShoppingCart.find_by(user_id: current_user.id)

      puts "Shopping cart ID: #{@shopping_cart.id}"

      @carts_article = CartsArticle.find_by(shopping_cart_id: @shopping_cart.id )
    else
      puts "NEMA USER-A!!!!"




      @no_articles = Article.where(id: $no_user_articles.keys)
      @sa = SingleArticle.where(id: $no_user_single_articles.keys)
    end


    # filterific ###########################################################################################################################
    @page_title = "Artikli"
    @filterrific = initialize_filterrific(Article.where(raw: false, for_sale: true), params[:filterrific], select_options: { sorted_by: Article.options_for_sorted_by,
                                                                                                                             with_category_id: Category.options_for_select,
                                                                                                                             with_material_id: Material.options_for_select}) or return


    @articles = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end

  rescue ActiveRecord::RecordNotFound => e
    # There is an issue with the persisted param_set. Reset it.
    puts "Had to reset filterrific params: #{ e.message }"
    redirect_to(reset_filterrific_url(format: :html)) and return

    ###########################################################################################################################

  end

  def show
    @article = Article.find(params[:format])

    rel_art_ids = []
    @rel_arts = []

    rel_art_ids = RelatedArticle.where(article_id: @article.id).pluck(:related_article_id)

    @rel_arts = Article.where(id: rel_art_ids)

    if current_user != nil
      @shopping_cart = ShoppingCart.find_by(user_id: current_user.id)

      puts "Shopping cart ID: #{@shopping_cart.id}"

      @carts_article = CartsArticle.find_by(shopping_cart_id: @shopping_cart.id )
    else
      puts "NEMA USER-A!!!!"
      @no_articles = Article.where(id: $no_user_articles.keys)

      @sa = SingleArticle.where(id: $no_user_single_articles.keys) # single article dodan ####################################################################################################
    end
  end
end
