class User < ApplicationRecord
    has_secure_password

    belongs_to :role
    
    has_many :enrollments, dependent: :destroy
    has_many :subjects, through: :enrollments

    has_many :courses, class_name: "Course"
    
    validates :name, presence: true
    validates :email, presence: true, uniqueness: { case_sensitive: false }

end
