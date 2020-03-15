class User < ApplicationRecord
	validates :name, { presence: { message: '：を入力してください。' },
                     length: { maximum: 20, message: '：20文字以内で入力してください。' } }

	validates :email, { presence: { message: ' ：を入力してください。' },
                      uniqueness: { message: '：は既に使用されています。' } }

	validates :password, { presence: { message: '：を入力してください。' },
                         length: { minimum: 6, message: '：6文字以上入力してください。' },
                         length: { maximum: 12, message: '：12文字以内で入力してください。' },
                         format: { with: /[0-9a-zA-Z]/, message: '：半角英数字で入力してください。' } }
end
