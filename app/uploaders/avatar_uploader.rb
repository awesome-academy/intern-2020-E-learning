class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :file

  def cache_dir
    "/tmp/e_learning_cache"
  end

  def store_dir
    "/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    process resize_to_fit: [200, 200]
  end

  def move_to_cache
    true
  end

  def move_to_store
    true
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
