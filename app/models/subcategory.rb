class Subcategory < ActiveRecord::Base
  has_many :articles

  has_many :category_subcategories
  has_many :categories, :through => :category_subcategories

  has_many :ssubcategory_subcategories
  has_many :ssubcategories, :through => :ssubcategory_subcategories
end
