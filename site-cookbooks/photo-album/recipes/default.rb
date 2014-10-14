#
# Cookbook Name:: photo-album
# Recipe:: default

include_recipe "photo-album::base"
include_recipe "photo-album::web"
include_recipe "photo-album::database"
