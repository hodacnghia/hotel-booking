class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :role
  validates_presence_of :name
  before_save :assign_role
  has_many :hotels  ,:dependent => :destroy
  def assign_role
    self.role = Role.find_by name: "Regular" if self.role.nil?
  end
  def admin?
    self.role.name == "Admin"
  end
end
