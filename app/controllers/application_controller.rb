class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception






  before_action :set_user


  def set_user
    if $no_user_articles == nil
    $no_user_articles = Hash.new
    $no_user_articles_int = Hash.new
    $no_user_single_articles = Hash.new
    $items_cost = 0

    end
  end
end


#### u layout-u za komplete kada se ubace

=begin
<% else %>

                        <li class="clearfix">
<%= link_to i.complement.title, complements_show_path(id: i.complement.id), class: "item-title" %>
                          <br/>
                          <% if i.complement.pictures.first != nil %>
<%=image_tag(i.complement.pictures.first.image.url(:table), class: "productimg") %>
                          <% elsif i.complement.article.picture != nil %>
<%=image_tag(i.complement.article.picture.image.url(:table), class: "productimg" ) %>
                          <% else %>
                              <%=image_tag("default-placeholder.png", class: "productimg" ) %>
<% end %>
    <!-- TODO napravi da se prikazuje slika od tocno tog single_article-a, a ne od cijelokupnog artikla -->
                                                                                                        <span class="item-price"><%=  number_to_currency(i.complement.cost, :unit => 'Kn', :format => "%n %u") %></span>
                          <span class="quantity"><%= i.amount %></span>
<%= link_to 'remove', destroy_complement_shopping_carts_path(i.complement.id), :method => :put, class: "quantity" %>
</li>
=end
