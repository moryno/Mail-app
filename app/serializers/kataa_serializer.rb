class KataaSerializer < ActiveModel::Serializer
  attributes :id, :question, :answer
  has_one :assessment
end
