module ApplicationHelper


  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Snapshot"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  # Helper for flash messages
  def alert_for(flash_type)
    { success: 'alert-success',
      error: 'alert-danger',
      alert: 'alert-warning',
      notice: 'alert-info'
    }[flash_type.to_sym] || flash_type.to_s
  end

  # Determines if the post is an image or not
  def form_image_select(post)
    return image_tag post.image.url(:medium),
                     id: 'image-preview',
                     class: 'img-responsive' if post.image.exists?
    image_tag 'placeholder.png', id: 'image-preview', class: 'img-responsive'
  end
end
