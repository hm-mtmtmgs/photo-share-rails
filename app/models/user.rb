class User < ApplicationRecord
	has_many(:post, dependent: :destroy)
	has_many(:like, dependent: :destroy)
	has_many(:comments, dependent: :destroy)
	has_many(:relationships, foreign_key: "user_id", dependent: :destroy)
  has_many(:reverse_of_relationships, class_name: "Relationship", foreign_key: "follow_id", dependent: :destroy)
	has_many(:followings, through: :relationships, source: :follow, dependent: :destroy)
	has_many(:followers, through: :reverse_of_relationships, source: :user, dependent: :destroy)
	has_secure_password(validations: false)
	mount_uploader(:icon, IconUploader)

	def follow(other_user)
		self.followings.push(other_user)
  end

  def unfollow(other_user)
		self.relationships.find_by(follow_id: other_user.id).destroy
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

	validates :name, { presence: { message: "を入力してください" },
                     length: { maximum: 12, message: "は12文字以内で入力してください", allow_blank: true } }

	validates :username, { presence: { message: "を入力してください" },
												 uniqueness: { message: "は既に使用されています", allow_blank: true },
												 length: { maximum: 16, message: "は16文字以内で入力してください", allow_blank: true },
											   format: { with: /[0-9a-zA-Z]/, message: "は半角英数字で入力してください", allow_blank: true } }

	validates :email, { presence: { message: "を入力してください" },
											uniqueness: { message: "は既に使用されています", allow_blank: true },
											format: { with: /([0-9a-zA-Z])+([0-9a-zA-Z\._-])*@([0-9a-zA-Z_-])+([0-9a-zA-Z\._-]+)+/, message: "を正しく入力してください", allow_blank: true } }

	validates :password, { presence: { message: "を入力してください" },
												 length: { within: 6..12, message: "は6文字以上12文字以内で入力してください", allow_blank: true },
												 format: { with: /[0-9a-zA-Z]/, message: "は半角英数字で入力してください", allow_blank: true },
												 confirmation: { message: "パスワードが一致しません", allow_blank: true },
												 if: :password_confirmation }

	validates :introduction, { length: { maximum: 150, message: "は150文字以内で入力してください" } }
end
