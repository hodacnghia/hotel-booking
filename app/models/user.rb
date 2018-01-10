class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook,:google_oauth2]
  belongs_to :role , optional: true
  has_many :orders
  has_many :rooms , :through => :orders
  before_save :assign_role
  has_many :hotels  ,:dependent => :destroy
  ratyrate_rater
  def assign_role
    self.role = Role.find_by name: "Regular" if self.role.nil?
  end
  def admin?
    self.role.name == "Admin"
  end
  def regular?
    self.role.name == "Regular"
  end
  def host?
    self.role.name == "Host"
  end
  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:provider => access_token.provider, :uid => access_token.uid ).first
    if user
      return user
    else
      registered_user = User.where(:email => access_token.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(name: data["name"],
          provider:access_token.provider,
          email: data["email"],
          uid: access_token.uid ,
          password: Devise.friendly_token[0,20],
        )
      end
   end
end
  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first


    unless user
        user = User.create(name: data['name'],
           email: data['email'],
           password: Devise.friendly_token[0,20]
        )
    end
    user
end
#
# geocoded_by :full_address # full_address is a method which take some model's attributes to get a formatted address for example
#
#   # the callback to set longitude and latitude
#   after_validation :geocode
#
#   # the full_address method
#   def full_address
#     "#{address}, #{zipcode}, #{city}, #{country}"
#   end

end
