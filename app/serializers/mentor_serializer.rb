class MentorSerializer < ActiveModel::Serializer

  attributes :id, :first_name, :last_name ,:work_id, :email, :role
  has_many :assessments
end
