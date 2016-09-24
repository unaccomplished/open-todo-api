class List < ActiveRecord::Base
  belongs_to :user
  has_many :items, dependent: :destroy

  before_save { self.permissions ||= :open}

  enum permissions: [:open, :viewable, :admin_only]

  validates :title, presence: true
  # Below is not needed here, controller is handling this
  # validates :permissions, presence: true, on: :update, if: :not_private?
  #
  # def not_private?
  #   !self.admin_only?
  # end
end
