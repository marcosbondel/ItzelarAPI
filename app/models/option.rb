class Option < ApplicationRecord
    belongs_to :question

    validates :option_text, presence: true
    validates :is_correct, inclusion: { in: [true, false] }
end
