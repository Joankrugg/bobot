module ApplicationHelper
  def cl_image_path_with_default(photo_path, options = {})
    if photo_path
      cl_image_path(photo_path, options)
    else
      cl_image_tag("i9ipg5arxwhnejrke9vi.jpg", options)
    end
  end
end
