class Exam < ApplicationRecord
    belongs_to :course

    has_many :questions, class_name: "::Question", dependent: :destroy

    # validates :title, presence: true
    # validates :description, presence: true
end
