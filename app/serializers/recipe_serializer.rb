class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :name, :preparation_time, :cooking_time, :description, :public
  has_one :user
end
