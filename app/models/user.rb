class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :omniauthable, omniauth_providers: [:github]

  serialize :github_data, JSON

  def self.from_omniauth data
    github_id = data.uid
    if user = User.find_by(github_id: github_id)
      user
    else
      where(github_id: github_id).create! do |u|
        u.email = data["info"]["email"]
        u.password = SecureRandom.hex 64
        u.github_id = github_id
        u.auth_data = data
      end
    end
  end

end
