class Question < ApplicationRecord

  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_many :question_tags, dependent: :destroy
  has_many :tags, through: :question_tags, source: :tag

  validates :text, :user, presence: true

  validates_length_of :text, maximum: 255, message: 'максимум 255 символов'

  before_save :build_tags

  def build_tags
    hashs = hashtags_from_fields

    #убираем уже привязанные к вопросу теги
    hash_existed = tags.map(&:name)
    hashs -= hash_existed if hashs && hash_existed

    #привязываем новые теги, если они есть
    if hashs
      hashs.each do |tag_name|
        tag = Tag.find_or_initialize_by(name: tag_name)
        question_tags.build(tag: tag)
      end
    end
  end

  def hashtags_from_fields
    #массив тегов из текстов вопроса и ответа
    tag_regexp = /#[[:word:]-]+/
    hashtags_from_text = []
    hashtags_from_answer = []

    hashtags_from_text = text.scan(tag_regexp) if text
    hashtags_from_answer = answer.scan(tag_regexp) if answer

    (hashtags_from_text + hashtags_from_answer).uniq
  end
end
