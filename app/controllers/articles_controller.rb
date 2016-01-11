class ArticlesController < ApplicationController
  def index
    @page_title = "Artikli"
    @filterrific = initialize_filterrific(Article.where(raw: false), params[:filterrific], select_options: { sorted_by: Article.options_for_sorted_by,
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

  end

  def show

  end

  #############################################################################################################################################################################

  def show_pics

  end

end
