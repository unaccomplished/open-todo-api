class Item < ActiveRecord::Base
  belongs_to :list

  validates :text, presence: true

  include Swagger::Blocks

  swagger_schema :Item do
    key :id, :Item
    key :required, [:list_id, :text]
    property :id do
      key :type, :integer
      key :format, :int64
      key :description, 'unique indentifier for the item'
    end
    property :text do
      key :type, :string
    end
    property :list_id do
      key :type, :integer
      key :format, :int64
    end
  end

  swagger_schema :ItemInput do
    allOf do
      schema do
        key :'$ref', :Item
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
