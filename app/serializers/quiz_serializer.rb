class QuizSerializer < ActiveModel::Serializer
  attributes :id, :question, :answers, :correct_answer, :assessment_id, :time_limit
end
