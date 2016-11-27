class Api::UsersController < ApiController
  before_action :authenticated?
  include Swagger::Blocks

  swagger_path '/api/users' do
    operation :get do
      key :description, 'Returns all users'
      key :operationId, 'returnAllUsers'
      key :produces, [
        'application/json',
        'text/html',
      ]
      key :tags, [
        'user'
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
        key :description, 'Password for login'
        key :required, true
        key :type, :string
      end
      response 200 do
        key :description, 'return all users'
        schema type: :array do
          items do
          key :'$ref', :User
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
  swagger_path 'api/users' do
    operation :post do
      key :description, 'Create user'
      key :operationId, 'addUser'
      key :produces, [
        'application/json'
      ]
      key :tags, [
        'user'
      ]
      parameter do
        key :name, :string
        key :in, :body
        key :description, 'Full name of new user'
        key :required, true
        key :type, :string
      end
      parameter do
        key :password, :password_digest
        key :in, :body
        key :description, 'Password for new user'
        key :required, true
        key :type, :string
      end
      parameter do
        key :email, :string
        key :in, :body
        key :description, 'Email for new user'
        key :required, true
        key :type, :string
      end
      response 200 do
        key :description, 'new user created'
        schema do
          key :type, :array
          items do
            key :'$ref', :User
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
  swagger_path 'api/users/{id}' do
    operation :delete do
      key :description, 'Deletes a single user based on the ID supplied'
      key :operationId, 'deleteUser'
      parameter do
        key :name, :id
        key :in, :path
        key :description, 'ID of user to delete'
        key :required, true
        key :type, :integerkey
        key :format, :int64
        schema do
          key :'$ref', :UserInput
        end
      end
      response 204 do
        key :description, 'user deleted'
      end
      response :default do
        key :description, 'unexpected error'
        schema do
          key :'$ref', :ErrorModel
        end
      end
    end
  end

  def index
    users = User.all

    render json: users, each_serializer: UserSerializer
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    begin
      user = User.find(params[:id])
      user.destroy
      render json: {}, status: :no_content
    rescue ActiveRecord::RecordNotFound
      render :json => {}, :status => :not_found
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password_digest, :email, :bio)
  end

end
