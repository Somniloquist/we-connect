module UsersHelper
  def gravatar_for(user, size=80)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://www.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: "#{user.firstname} #{user.lastname}", class: "avatar gravatar")
  end

  # Set custom avatar if user has uploaded one else use gravatar
  def avatar_for(user, size=80)
    user.avatar.attached? ? image_tag(url_for(user.set_avatar(size)), class: "avatar") : gravatar_for(user, size)
  end

  # creates or loads a variant of height, use to generate 
  # thumbnails/previews
  def banner_for(user, height=100)
    image_tag(url_for(user.set_banner(height)))
  end

end
