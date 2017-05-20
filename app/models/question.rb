class Question < ApplicationRecord

  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_many :question_tags, dependent: :destroy
  has_many :tags, through: :question_tags, source: :tag

  validates :text, :user, presence: true

  validates_length_of :text, maximum: 255, message: 'максимум 255 символов'
end
