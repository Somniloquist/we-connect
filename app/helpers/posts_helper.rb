module PostsHelper

  def image_for(post, size=500, crop=false, css_class="image-large")
    image_tag(url_for(post.set_image(size, crop)), class: css_class) 
  end

end
