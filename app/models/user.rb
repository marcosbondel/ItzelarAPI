class User < ApplicationRecord
    has_secure_password

    belongs_to :role
    
    has_many :enrollments, dependent: :destroy
    has_many :subjects, through: :enrollments
    has_many :courses
    has_many :answers
    has_many :sessions
    
    validates :name, presence: true
    validates :email, presence: true, uniqueness: { case_sensitive: false }

    def show
        {
            :name => self.name,
            :lastname => self.lastname,
            :email => self.email,
            :role => self.role.name
        }
    end

    def admin?
        self.role.name.eql? 'admin'
    end
    
    def professor?
        self.role.name.eql? 'professor'
    end
    
    def student?
        self.role.name.eql? 'student'
    end
end
