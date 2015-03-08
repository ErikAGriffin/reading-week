require 'bcrypt'

class User

  include DataMapper::Resource

  attr_reader :password
  attr_accessor :password_confirmation

  validates_confirmation_of :password

  property :id, Serial
  property :username, String, unique: true, required: true
  property :password_hash, Text
  has n, :projectIdeas
  # Hmm.. how to do favorites?
  # Users need a 1 to many on Ideas they own
  # Yet a many to many on Ideas they like

  def password=(input)
    @password = input
    self.password_hash = BCrypt::Password.create(input)
  end

end
