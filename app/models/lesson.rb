class Lesson < ApplicationRecord
    belongs_to :course

    validates :title, presence: true
    validates :content, presence: true
end
