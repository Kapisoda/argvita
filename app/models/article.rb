class Article < ActiveRecord::Base

  has_many :carts_articles
  has_many :shopping_carts, :through => :carts_articles

  has_many :article_categories
  has_many :categories, :through => :article_categories

  belongs_to :material
  belongs_to :subcategory
  belongs_to :ssubcategory

  belongs_to :picture

  has_many :coupons

  has_many :single_articles
  accepts_nested_attributes_for :single_articles, allow_destroy: true

  has_many :pictures, :dependent => :destroy



  def provjera
    @article= Article.all
    @article.each do |article|
      if article.start_date != nil && article.end_date != nil
        if DateTime.now >= article.start_date && DateTime.now < article.end_date
          article.on_discount = true
          article.save
        elsif DateTime.now > article.end_date
          article.on_discount = false
          article.save
        end
      end
    end
  end





  #filterrific
  filterrific(
      default_filter_params: { sorted_by: 'created_at_desc' },
      available_filters: [
          :sorted_by,
          :search_query,
          :with_material_id,
          :with_category_id,
          :with_cost_gte,
          :with_created_at_gte,
          :min_cost,
          :max_cost,
          :with_subcategory_id,
          :with_ssubcategory_id
      ]
  )


  # define ActiveRecord scopes for
  # :search_query, :sorted_by, :with_country_id, and :with_created_at_gte

  scope :sorted_by, lambda { |sort_option|
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
      when /^cost_/

        order("articles.cost #{ direction }")
      when /^created_at_/

        order("articles.created_at #{ direction }")
      when /^updated_at_/

        order("articles.updated_at #{ direction }")
      when /^title_/

        order("LOWER(articles.title) #{ direction }")
      else
        raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

# scopovi za podkategorije i podpodkategorije
  scope :with_subcategory_id, lambda { |subcategory_ids|
    where(category_id: [*subcategory_ids])
  }

  scope :with_ssubcategory_id, lambda { |ssubcategory_ids|
    where(category_id: [*ssubcategory_ids])
  }

##################################################################



 #scopovi za cijene
  scope :with_cost_gte, lambda { |ref_int|
    where(cost: [*ref_int])
  }


  scope :max_cost, lambda { |ref_int|

    where("articles.cost < ?", [*ref_int])
  }

  scope :min_cost, lambda { |ref_int|

    where("articles.cost > ?", [*ref_int])
  }

######################################################



  scope :with_category_id, lambda { |category_ids|
    where(category_id: [*category_ids])
  }

  scope :with_material_id, lambda { |material_ids|
    where(material_id: [*material_ids])
  }

  scope :with_created_at_gte, lambda { |ref_date|
    where(created_at: [*ref_date])
  }

  scope :search_query, lambda { |query|

    return nil  if query.blank?


    terms = query.downcase

    # replace "*" with "%" for wildcard searches,
    # append '%', remove duplicate '%'s

    # configure number of OR conditions for provision
    # of interpolation arguments. Adjust this if you
    # change the number of OR conditions.
    num_or_conds = 1
    where(
        "(LOWER(articles.title) LIKE ? OR LOWER(articles.title_eng) LIKE ?)", "%#{terms}%", "%#{terms}%"
    )
  }

  def self.options_for_sorted_by
    [
        ['Cijeni (od najmanje)', 'cost_asc'],
        ['Cijeni (od najvise)', 'cost_desc'],
        ['Nazivu (a-z)', 'title_asc'],
        ['Datumu kreiranja (najnoviji)', 'created_at_desc'],
        ['Datumu kreiranja (stariji)', 'created_at_asc'],
        ['Datumu izmjene (najnoviji)', 'updated_at_desc'],
        ['Datumu izmjene (stariji)', 'updated_at_asc']
    ]
  end
end

