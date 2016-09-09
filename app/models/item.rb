class Item < ActiveRecord::Base
  belongs_to :list

  validates :text, presence: true
end
