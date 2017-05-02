class Question < ApplicationRecord

  belongs_to :user

  validates :text, :user, presence: true

#домашка 49-1
  validates_length_of :text, maximum: 255, message: 'максимум 255 символов'
end
