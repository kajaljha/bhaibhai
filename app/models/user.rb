class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable


  mount_uploader :image, ImageUploader

  after_create :update_user_auth_token
  
  has_many :parking_places
  has_many :feedbacks
  
  def as_json(options={})
    super(:only => [:auth_token, :name, :email], :methods => [:image_file_for_api])
  end

  def generate_auth_token(token)
    # token = (0...10).map{25.+(rand(20))}.join
    self.update(auth_token: token)
  end

  def update_user_auth_token
    token = AuthToken.issue_token({user_id: self.id})
    self.generate_auth_token(token)
  end

  def self.from_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(
                          provider:auth.provider,
                          uid:auth.uid,
                          email:auth.info.email,
                          password:Devise.friendly_token[0,20],
                        )
      end    
    end
  end

  def image_file
    image.nil? ? "default_user.png" : image.try(:url)
  end

  def image_file_for_api
    image.nil? ? "https://cdn0.iconfinder.com/data/icons/avatars-6/500/Avatar_boy_man_people_account_client_male_person_user_work_sport_beard_team_glasses-512.png" : image.try(:url)
  end
end
