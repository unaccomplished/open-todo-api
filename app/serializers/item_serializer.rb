class ItemSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :list_id, :text

  def created_at
    object.created_at.strftime('%B %d, %Y')
  end

end
