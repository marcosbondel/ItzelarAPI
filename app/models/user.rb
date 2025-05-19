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

    validates :password, presence: true, length: { minimum: 8 }, if: :password
    validate :password_complexity, if: :password

    def password_complexity
        return if password.blank?

        unless password.match?(/\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_])/)
            errors.add :password, 'Must include at least one lowercase letter, one uppercase letter, one digit, and one special character'
        end
    end
    
    def show
        {
            :name => self.name,
            :lastname => self.lastname || '',
            :email => self.email,
            :role => self.role.name
        }
    end

    def self.list
        self.joins(:role).select(
            :id,
            :name,
            :lastname,
            :email,
            "roles.name as role_name"
        )
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
