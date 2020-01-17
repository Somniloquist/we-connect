module PostsHelper

  def image_for(post, size=500, crop=false)
    image_tag(url_for(post.set_image(size, crop)), class: "post-image") 
  end

end
