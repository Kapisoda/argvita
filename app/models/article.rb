class Article < ActiveRecord::Base
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
end
