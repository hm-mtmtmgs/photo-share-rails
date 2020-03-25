class Like < ApplicationRecord
	belongs_to(:user)
	belongs_to(:post)

	validates_uniqenness_of :post_id, { scope: :user_id }
end
