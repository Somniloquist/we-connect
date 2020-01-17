module PostsHelper

  def image_for(post, size=500)
    image_tag(url_for(post.set_image(size)), class: "post-image") 
  end

end
