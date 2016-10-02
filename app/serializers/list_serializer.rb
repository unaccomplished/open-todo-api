class ListSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :user_id, :title

  def created_at
    object.created_at.strftime('%B %d, %Y')
  end
end
