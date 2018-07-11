class User < ApplicationRecord
  has_many :pams_answers
  belongs_to :manager
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise  :database_authenticatable,
          :registerable,
          :recoverable,
          :rememberable,
          :trackable,
          :validatable,
          authentication_keys: [:email]

  def update_with_password(params, * options)
   if params[:password].blank?
   params.delete(:password)
   params.delete(:password_confirmation) if params[:password_confirmation].blank?
  end
   update_attributes(params, * options)
  end

  validates :manager_id, presence: true

end
