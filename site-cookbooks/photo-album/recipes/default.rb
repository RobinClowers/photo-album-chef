#
# Cookbook Name:: photo-album
# Recipe:: default

user "deploy"

user "deploy" do
  action :lock
end

directory "/home/deploy" do
  action :create
  owner 'deploy'
  group 'deploy'
  mode '0755'
end

directory "/srv/photo_album" do
  action :create
  owner 'deploy'
  group 'deploy'
  mode '0755'
end

directory "/srv/photo_album/shared" do
  action :create
  owner 'deploy'
  group 'deploy'
  mode '0755'
end

directory "/srv/photo_album/releases" do
  action :create
  owner 'deploy'
  group 'deploy'
  mode '0755'
end

puma_config "photo_album" do
  directory "/srv/photo_album"
  environment 'staging'
  monit true
  logrotate true
  thread_min 0
  thread_max 16
  workers 2
end
