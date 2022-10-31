class Assessment < ApplicationRecord
  belongs_to :mentor
  has_many :quizzes, dependent: :destroy
  has_many :proses, dependent: :destroy
  has_many :kataas, dependent: :destroy
  validates :title, presence: true, uniqueness: true
end
