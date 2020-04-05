class Comment < ApplicationRecord
	belongs_to(:post)
	belongs_to(:user)

	validates :post_id, { presence: true }
	validates :user_id, { presence: true }
	validates :comment, { presence: { message: "を入力してください" },
                        length: { maximum: 100, message: "は100文字以内で入力してください" } }
end
