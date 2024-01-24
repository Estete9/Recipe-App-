class FoodSerializer < ActiveModel::Serializer
  attributes :id, :name, :measurement_unit, :price
end
