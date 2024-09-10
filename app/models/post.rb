class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :media
  validates :media, presence: true

  enum state: { everyone: 0, close_friends: 1, archived: 2 }

  after_initialize :set_default_state, if: :new_record?
  accepts_nested_attributes_for :comments

  private

  def set_default_state
    self.state ||= :everyone
  end
end
