#
# Cookbook Name:: photo-album
# Recipe:: default

puma_config "photo_album" do
  directory "/srv/app"
  environment 'staging'
  monit true
  logrotate true
  thread_min 0
  thread_max 16
  workers 2
end
