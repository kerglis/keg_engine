AppConfig = ConfigSpartan.create do
  begin
    file "#{Rails.root}/config/app_config.yml"
    file "#{Rails.root}/config/environments/#{Rails.env}.yml"
  rescue
  end
end