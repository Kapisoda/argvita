class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_user


  def set_user
    if $no_user_articles == nil
    $no_user_articles = Hash.new
    $no_user_articles_int = Hash.new
    $items_cost = 0
    end
  end
end
