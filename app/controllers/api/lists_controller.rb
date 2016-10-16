class Api::ListsController < ApiController
  before_action :authenticated?
  before_action :list_privacy, only: :update

  swagger_controller :lists, "List Management"

  swagger_api :create do
    summary "Creates a new List"
    param :form, :title, :string, :required, "Title"
    param :form, :user_id, :integer, :required, "User Id"
    param_list :form, :permissions, :string, :required, "Permissions", [ "open", "viewable", "admin_only" ]
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing List"
    param :path, :id, :integer, :optional, "List Id"
    response :unauthorized
    response :not_found
  end

  swagger_api :update do
    summary "Updates an existing List"
    param :form, :title, :string, :required, "Title"
    param :form, :user_id, :integer, :optional, "User Id"
    param_list :form, :permissions, :string, :optional, "Permissions", [ "open", "viewable", "admin_only" ]
    response :unauthorized
    response :not_found
    response :not_acceptable
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
