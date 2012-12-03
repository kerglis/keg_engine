AppConfig = ConfigSpartan.create do
  file "#{Rails.root}/config/app_config.yml"                if File.exists?("#{Rails.root}/config/app_config.yml")
  file "#{Rails.root}/config/environments/#{Rails.env}.yml" if File.exists?("#{Rails.root}/config/environments/#{Rails.env}.yml")
end