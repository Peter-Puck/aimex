class User < ApplicationRecord

	acts_as_messageable

	has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "missing_user.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email

  def full_name
  	"#{last_name.upcase}, #{first_name}".strip
  end

  def full_name_first_last
    	"#{first_name} #{last_name.upcase}"
  end 

  def remember_me
    (super == nil) ? '1' : super
    end
end
