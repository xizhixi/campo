class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def exif_rotation
    manipulate! do |img|
      img.auto_orient
      img = yield(img) if block_given?
      img
    end
  end

  VERSION_SIZES = {
    normal: 48,
    bigger: 96,
    original: 1080
  }

  def default_url
    if model.respond_to? :gravatar_url
      model.gravatar_url(size: VERSION_SIZES[version_name])
    end
  end

  VERSION_SIZES.each do |version_name, size|
    version version_name do
      if version_name.to_s == "original"
        process resize_to_limit: [size, size*16/9]
        process :exif_rotation
      else
        process resize_to_fill: [size, size]
        process :exif_rotation
      end
    end
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
