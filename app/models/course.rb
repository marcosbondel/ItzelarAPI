class Course < ApplicationRecord
    belongs_to :user
    
    has_many :exams, dependent: :destroy
    has_many :enrollments, dependent: :destroy
    has_many :students, through: :enrollments

    validates :name, presence: true
    validates :description, presence: true

    def self.list
        self.select(
            :id,
            :name,
            :description,
        )
    end

    def show
        {
            id: id,
            name: name,
            description: description,
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
