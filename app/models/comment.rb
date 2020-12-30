class Comment < ApplicationRecord
  COMMENT_PARAMS = %i(user_id content).freeze
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validates :content,
            presence: true,
            length: {maximum: Settings.description.max_length}
end
