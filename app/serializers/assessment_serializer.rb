class AssessmentSerializer < ActiveModel::Serializer
  attributes :id, :title, :duedate
  has_many :quizzes
  has_many :proses
  has_many :kataas
end
