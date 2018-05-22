class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    '/assets/event-placeholder.jpg'
  end

  version :small_event do
    # returns a 35x35 image
    process :auto_orient
    process :resize_to_fill => [250, 250]
  end

  version :big_event do
    # returns a 35x35 image
    process :auto_orient
    process :resize_to_fill => [500, 500]
  end


  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def auto_orient
    manipulate! do |img|
      img = img.auto_orient
    end
  end

end
