class Enrollment < ApplicationRecord
    belongs_to :user
    belongs_to :course

    def self.list
        self.joins(:user, :course).map do |enrollment|
            
            {
                id: enrollment.id,
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
            user: {
                id: self.user.id,
                name: self.user.name,
                email: self.user.email
            },
            course: {
                id: self.course.id,
                name: self.course.name,
                description: self.course.description,
            }
        }
    end
end
