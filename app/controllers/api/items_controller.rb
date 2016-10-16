class Api::ItemsController < ApiController
  before_action :authenticated?

  swagger_controller :items, "Item Management"

  swagger_api :create do
    summary "Creates a new item"
    param :form, :text, :string, :required, "Item Text"
    param :form, :list_id, :integer, :required, "List Id"
    param :form, :complete, :boolean, :optional, "Completed? true or false"
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :update do
    summary "Updates an existing item"
    param :path, :id, :integer, :required, "Item Id"
    param :form, :text, :string, :optional, "Item Text"
    param :form, :list_id, :integer, :optional, "List Id"
    param :form, :complete, :boolean, :optional, "Completed? true or false"
    response :unauthorized
    response :not_found
    response :not_acceptable
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
