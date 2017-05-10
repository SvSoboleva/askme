class Question < ApplicationRecord

  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  validates :text, :user, presence: true

#домашка 49-1
  validates_length_of :text, maximum: 255, message: 'максимум 255 символов'
end
