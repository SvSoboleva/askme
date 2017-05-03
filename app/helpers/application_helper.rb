module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end

#домашка 50-1
  def sklonenie(number, krokodil, krokodila, krokodilov)
    # Сначала, проверим входные данные на правильность
    if number == nil || !number.is_a?(Numeric)
      number = 0
    end

    ostatok = number % 10
    ostatok_100 = number % 100

    if ostatok == 1 && ostatok_100 != 11
      return krokodil
    elsif (ostatok >= 2 && ostatok <= 4) && (ostatok_100 < 12 || ostatok_100 > 14 )
      return krokodila
    elsif (ostatok >= 5 && ostatok <= 9) || ostatok == 0 || (ostatok_100 >= 11 && ostatok_100 <= 14)
      return krokodilov
    end
  end
end
