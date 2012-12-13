ActiveAdmin.register Author do
  menu false
  actions :show

  show do |author|
    author.images.each do |image|
      image_tag image.link
    end
  end

end
