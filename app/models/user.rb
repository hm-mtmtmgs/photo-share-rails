class User < ApplicationRecord
	validates :name, { presence: { message: "を入力してください。" },
                     length: { maximum: 20, message: "は20文字以内で入力してください。" } }

	validates :email, { presence: { message: "を入力してください。" },
                      uniqueness: { message: "は既に使用されています。" } }

	validates :password, { presence: { message: "を入力してください。" },
                         length: { within: 6..12, message: "は6文字以上12文字以内で入力してください。" },
                         format: { with: /[0-9a-zA-Z]/, message: "は半角英数字で入力してください。" },
											   confirmation: { message: "パスワードが一致しません。"} }
end
