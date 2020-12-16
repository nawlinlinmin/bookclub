class IconUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  version :resize_for_book_icon do
    process resize_to_limit: [140, 170]
  end

  version :resize_for_user_icon do
    process resize_to_limit: [100, 100]
  end

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
