class Question < ApplicationRecord
    belongs_to :exam

    has_many :options, class_name: "::Option", dependent: :destroy

    validates :question_text, presence: true

    enum :question_type, {
        open: 'open',
        multiple_choice: 'multiple_choice',
        true_false: 'true_false'
    }
end