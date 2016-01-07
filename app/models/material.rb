class Material < ActiveRecord::Base
  has_many :articles

  has_many :category_materials
  has_many :categories, :through => :category_materials
end
