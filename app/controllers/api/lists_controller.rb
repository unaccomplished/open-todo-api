class Api::ListsController < ApiController
  before_action :authenticated?
  before_action :list_privacy, only: :update
  include Swagger::Blocks

  swagger_path '/api/users/{user_id}/lists' do
      operation :post do
      key :description, 'Create list'
      key :operationId, 'addList'
      key :produces, [
        'application/json'
      ]
      key :tags, [
        'list'
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
        key :description, 'Title of new list'
        key :required, true
        key :type, :string
      end
      parameter do
        key :permissions, :enum
        key :in, :body
        key :description, 'Permission of new list (:open, :viewable, :admin_only)'
      end
      response 200 do
        key :description, 'new list created'
        schema do
          key :type, :array
          items do
            key :'$ref', :List
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
  swagger_path '/api/users/{user_id}/lists/{id}' do
      operation :put do
      key :description, 'Update list'
      key :operationId, 'updateList'
      key :produces, [
        'application/json'
      ]
      key :tags, [
        'list'
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
        key :description, 'Updated title of new list'
        key :required, true
        key :type, :string
      end
      parameter do
        key :permissions, :enum
        key :in, :body
        key :description, 'Updated permission of new list (:open, :viewable, :admin_only)'
      end
      response 200 do
        key :description, 'list updated'
        schema do
          key :type, :array
          items do
            key :'$ref', :List
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
  swagger_path 'api/users/{user_id}/lists/{id}' do
    operation :delete do
      key :description, 'Deletes a single list based on the ID supplied'
      key :operationId, 'deleteList'
      parameter do
        key :name, :id
        key :in, :path
        key :description, 'ID of list to delete'
        key :required, true
        key :type, :integerkey
        key :format, :int64
        schema do
          key :'$ref', :UserInput
        end
      end
      response 204 do
        key :description, 'list deleted'
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
    list = List.new(list_params)
    if list.save
      render json: list
    else
      render json: { errors: list.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    begin
      list = List.find(params[:id])
      list.destroy
      render json: {}, status: :no_content
    rescue ActiveRecord::RecordNotFound
      render :json => {}, :status => :not_found
    end
  end

  def update
    list = List.find(params[:id])
    if list.update(list_params)
      render json: list
    else
      render json: { errors: list.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def list_params
    params.require(:list).permit(:title, :user_id, :permissions)
  end

  def list_privacy
    list = List.find(params[:id])
    if list.admin_only?
      render json: { error: "Cannot update List with admin only permissions" }, status: :unprocessable_entity
    end
  end

end
