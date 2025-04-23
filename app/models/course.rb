class Course < ApplicationRecord
    belongs_to :user
    
    has_many :enrollments, dependent: :destroy
    has_many :students, through: :enrollments, source: :user
    has_many :lessons, dependent: :destroy
    has_many :exams, class_name: "::Exam", dependent: :destroy

    validates :name, presence: true
    validates :description, presence: true
    validates :category, presence: true

    enum :category, %i(math physics chemistry biology history geography literature art music sports)

    def self.list
        self.select(
            :id,
            :name,
            :description,
            :category
        )
    end

    def show
        {
            id: id,
            name: name,
            description: description,
            category: category,
            students_enrolled_count: students.count,
            students_enrolled: students.map { |student| { id: student.id, name: student.name, lastname: student.lastname, email: student.email } },
            teacher: {
                id: user.id,
                name: user.name,
                lastname: user.lastname,
                email: user.email,
                role: user.role.name,
            }
        }
    end
end
