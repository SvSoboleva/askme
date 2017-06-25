class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_many :question_tags, dependent: :destroy
  has_many :tags, through: :question_tags, source: :tag

  validates :text, :user, presence: true

  validates_length_of :text, maximum: 255, message: 'максимум 255 символов'

  before_save :build_tags

  private

  def build_tags
    question_tags.delete_all
    hashs = (text + ' ' + answer.to_s).scan(Tag::TAGREGEXP).uniq

    #привязываем новые теги, если они есть
    hashs.each do |tag_name|
      tags << Tag.find_or_create_by(name: tag_name)
    end
  end
end
