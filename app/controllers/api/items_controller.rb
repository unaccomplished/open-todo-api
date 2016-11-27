class Api::ItemsController < ApiController
  before_action :authenticated?
  include Swagger::Blocks

  swagger_path '/api/lists/{list_id}/items' do
      operation :post do
      key :description, 'Create Item'
      key :operationId, 'addItem'
      key :produces, [
        'application/json'
      ]
      key :tags, [
        'item'
      ]
      parameter do
        key :name, :string
        key :in, :body
        key :description, 'Full name of user'
        key :required, true
        key :type, :string
      end
      parameter do
        key :password, :password_digest
        key :in, :body
        key :description, 'Password for user'
        key :required, true
        key :type, :string
      end
      parameter do
        key :text, :string
        key :in, :body
        key :description, 'Text of item'
        key :required, true
        key :type, :string
      end
      parameter do
        key :list_id, :integer
        key :in, :body
        key :description, 'List ID to add item to'
        key :required, true
        key :type, :integer
        key :format, :int64
      end
      response 200 do
        key :description, 'new item created'
        schema do
          key :type, :array
          items do
            key :'$ref', :Item
          end
        end
      end
      response :default do
        key :description, 'unexpected error'
        schema do
          key :'$ref', :ErrorModel
        end
      end
    end
  end
  swagger_path '/api/lists/{list_id}/items/{id}' do
      operation :put do
      key :description, 'Update item'
      key :operationId, 'updateItem'
      key :produces, [
        'application/json'
      ]
      key :tags, [
        'item'
      ]
      parameter do
        key :name, :string
        key :in, :body
        key :description, 'Full name of user'
        key :required, true
        key :type, :string
      end
      parameter do
        key :password, :password_digest
        key :in, :body
        key :description, 'Password for user'
        key :required, true
        key :type, :string
      end
      parameter do
        key :title, :string
        key :in, :body
        key :description, 'Updated item text'
        key :required, true
        key :type, :string
      end
      parameter do
        key :list_id, :integer
        key :in, :body
        key :description, 'List ID that updated item belongs to'
        key :required, true
        key :type, :integer
        key :format, :int64
      end
      response 200 do
        key :description, 'item updated'
        schema do
          key :type, :array
          items do
            key :'$ref', :Item
          end
        end
      end
      response :default do
        key :description, 'unexpected error'
        schema do
          key :'$ref', :ErrorModel
        end
      end
    end
  end


  def create
    item = Item.new(item_params)
    if item.save
      render json: item
    else
      render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      render json: item
    else
      render json: { errors: item.errors.full_messages }, status: unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:text, :list_id, :complete)
  end

end
