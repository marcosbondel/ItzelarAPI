class Enrollment < ApplicationRecord
    belongs_to :user
    belongs_to :course

    validates :status, presence: true

    enum :status, %i(enrolled completed)

    def self.list
        self.joins(:user, :course).map do |enrollment|
            
            {
                id: enrollment.id,
                status: enrollment.status,
                user: {
                    id: enrollment.user.id,
                    name: enrollment.user.name,
                    email: enrollment.user.email
                },
                course: {
                    id: enrollment.course.id,
                    name: enrollment.course.name,
                    description: enrollment.course.description,
                }
            }
        end
    end

    def show
        {
            id: self.id,
            course: {
                id: self.course.id,
                name: self.course.name,
                description: self.course.description,
            }
        }
    end
end
