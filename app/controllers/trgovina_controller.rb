class TrgovinaController < ApplicationController
  def index
    @categories = Category.all

    if current_user != nil
      @shopping_cart = ShoppingCart.find_by(user_id: current_user.id)
      @carts_article = CartsArticle.find_by(shopping_cart_id: @shopping_cart.id )
    else
      @articles_no_user = Article.where(id: $no_user_articles.keys)
    end


    # filterific ###########################################################################################################################
    @page_title = "Artikli"
    @filterrific = initialize_filterrific(Article.where(raw: false, for_sale: true), params[:filterrific], select_options: { sorted_by: Article.options_for_sorted_by,
                                                                                                                             with_category_id: Category.options_for_select,
                                                                                                                             with_material_id: Material.options_for_select}) or return
    if params[:page]
      @articles = @filterrific.find.page(params[:page])
    else
      @articles = @filterrific.find.page(1)
    end
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
  end
end
