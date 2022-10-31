class Mentor < ApplicationRecord
    has_secure_password
    has_many :assessments, dependent: :destroy
    validates :work_id, presence: true, uniqueness: true
end
