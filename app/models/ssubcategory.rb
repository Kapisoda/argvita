class Ssubcategory < ActiveRecord::Base
  belongs_to :subcategory
  belongs_to :ssubcategory
end
