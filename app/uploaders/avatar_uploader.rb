# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    # For Rails 3.1+ asset pipeline compatibility:
    # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
    if self.model.gender == "m"
      '/assets/avatar-male-blendin.jpg'
    else
      '/assets/avatar-female-blendin.jpg'
    end
  end

  version :large_avatar do
    # returns a 150x150 image
    process :auto_orient
    process :resize_to_fill => [500, 500]
  end
  version :medium_avatar do
    # returns a 50x50 image
    process :auto_orient
    process :resize_to_fill => [200, 200]
  end
  version :small_avatar do
    # returns a 35x35 image
    process :auto_orient
    process :resize_to_fill => [50, 50]
  end

  version :small_event do
    # returns a 35x35 image
    process :auto_orient
    process :resize_to_fill => [250, 250]
  end

  version :big_event do
    # returns a 35x35 image
    process :auto_orient
    process :resize_to_fill => [450, 450]
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
