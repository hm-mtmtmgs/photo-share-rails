class Post < ApplicationRecord
	belongs_to(:user)
	has_many(:likes, dependent: :destroy)
	has_many(:comments, dependent: :destroy)
	mount_uploader(:image, ImageUploader)

	validates :image, { presence: { message: "を選択してください" } }

	validates :title, { presence: { message: "を入力してください" },
											length: { maximum: 30, message: "は30文字以内で入力してください" } }

	validates :message, { presence: { message: "を入力してください" },
												length: { maximum: 200, message: "は200文字以内で入力してください" } }
end
