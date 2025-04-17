class Role < ApplicationRecord
    has_many :users, dependent: :destroy

    validates :name, presence: true, uniqueness: { case_sensitive: false }

    # enum name: {
    #     student: "student",
    #     teacher: "teacher",
    #     admin: "admin"
    # }
end
