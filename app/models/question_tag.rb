class QuestionTag < ApplicationRecord
  belongs_to :tag
  belongs_to :question

  validates :question, presence: true
  validates :tag, presence: true
end
