module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end

  # Хелпер, рисующий span тэг с иконкой из font-awesome
  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end

  def hashtags(questions)
    hashtag_regexp = /#[[:word:]-]+/
    @hashtags = []
    if questions
      questions.each do |question|
        @hashtags += question.text.scan(hashtag_regexp) if question.text
        @hashtags += question.answer.scan(hashtag_regexp) if question.answer
      end
    end
    @hashtags.uniq!
  end
end
