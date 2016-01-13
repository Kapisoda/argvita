class Ssubcategory < ActiveRecord::Base
  belongs_to :subcategory
  belongs_to :ssubcategory
  def self.options_for_select
    order('LOWER(title)').map { |e| [e.title, e.id] }
  end
end
