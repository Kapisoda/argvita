class Picture < ActiveRecord::Base
  has_one :article

  belongs_to :article

  belongs_to :single_article
end
