class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :ldap_authenticatable, :rememberable, :trackable, :validatable,
  :authentication_keys => [:username]

  validates :tiun, presence: true, on: :update

  has_many :lendings
  has_many :references

  def self.find_by_tiun(tiun)
    tiun = tiun.to_i(16).to_s
    where(tiun: tiun).first
  end

  def ldap_before_save
    self.email = Devise::LDAP::Adapter.get_ldap_param(self.username,"mail").first
    self.first_name = Devise::LDAP::Adapter.get_ldap_param(self.username,"givenname").first
    self.last_name = Devise::LDAP::Adapter.get_ldap_param(self.username,"sn").first
  end

end
