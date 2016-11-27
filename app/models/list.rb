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

  include Swagger::Blocks

  swagger_schema :List do
    key :id, :List
    key :required, [:title, :permissions]
    property :id do
      key :type, :integer
      key :format, :int64
      key :description, 'unique indentifier for the list'
    end
    property :title do
      key :type, :string
      key :minimum, '1'
      key :maximium, '100'
    end
    property :permissions do
      key :type, :enum
    end
  end

  swagger_schema :ListInput do
    allOf do
      schema do
        key :'$ref', :List
      end
      schema do
        key :required, [:id]
        property :id do
          key :type, :integer
          key :format, :int64
        end
      end
    end
  end
end
