class Micropost < ApplicationRecord
  belongs_to :user
  scope :create_desc, ->{order(created_at: :desc)}
  scope :user_posts, ->(id){where(user_id: id)}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.content_value}
  validate  :picture_size

  def picture_size
    errors.add(:picture, I18n.t("picture_size")) if picture.size >
                                                    Settings.picture_size.megabytes
  end
end
