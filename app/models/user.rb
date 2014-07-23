class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include BCrypt

  field :name,          type: String
  field :email,         type: String
  field :password_hash, type: String

  validates :name,  presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :email, format: /\A[^@]+@[^@]+\.[^@]+\z/

  before_save :downcase_email

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def authenticate(password)
    self.password == password
  end

protected

  def downcase_email
    self.email = self.email.downcase
  end
end
