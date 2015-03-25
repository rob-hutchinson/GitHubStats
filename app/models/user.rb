class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, and :timeoutable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :omniauthable, omniauth_providers: [:github]

  serialize :auth_data, JSON

  def self.from_omniauth data
    github_id = data.uid
    user = User.where(github_id: github_id).first_or_create! do |u|
        u.email = data["info"]["email"]
        u.password = SecureRandom.hex 64
        u.github_id = github_id
        u.nickname = data["info"]["nickname"]
        u.auth_data = data
    end
  end

end
