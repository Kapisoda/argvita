class Material < ActiveRecord::Base
  has_many :articles

  has_many :category_materials
  has_many :categories, :through => :category_materials



  def self.options_for_select
    order('LOWER(title)').map { |e| [e.title, e.id] }
  end

end
