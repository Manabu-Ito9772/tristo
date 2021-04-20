# class BlockSerializer < ActiveModel::Serializer
#   attributes :id, :title, :place, :place_info, :comment, :arriving_time, :leaving_time
#   has_many :spendings
#   has_many :transportations
#
#   class SpendingSerializer < ActiveModel::Serializer
#     attributes :id, :genre, :description, :cost
#   end
#
#   class TransportationSerializer < ActiveModel::Serializer
#     attributes :id, :means, :description, :cost
#   end
# end
