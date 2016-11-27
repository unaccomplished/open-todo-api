class User < ActiveRecord::Base
  before_save { self.email = email.downcase if email.present? }

  validates :name, length: { minimum: 1, maximum: 100 }, presence: true
  validates :password, presence: true, length: { minimum: 6 }, unless: :password_digest
  validates :password, length: { minimum: 6 }, allow_blank: true
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 254 }

  has_secure_password

  has_many :lists, dependent: :destroy

  include Swagger::Blocks

  swagger_schema :User do
    key :id, :User
    key :required, [:name, :password, :email]
    property :id do
      key :type, :integer
      key :format, :int64
      key :description, 'unique indentifier for the user'
    end
    property :name do
      key :type, :string
      key :minimum, '1'
      key :maximium, '100'
    end
    property :email do
      key :type, :string
      key :minimum, '3'
      key :maximum, '254'
    end
    property :password do
      key :type, :string
      key :minimum, '6'
    end
    property :bio do
      key :type, :text
    end
  end

  swagger_schema :UserInput do
    allOf do
      schema do
        key :'$ref', :User
      end
      schema do
        key :required, [:name]
        property :id do
          key :type, :integer
          key :format, :int64
        end
      end
    end
  end

  def full_name
    self.name
  end
end
