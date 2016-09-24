class Api::ListsController < ApiController
  before_action :authenticated?
  before_action :list_privacy, only: :update

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
