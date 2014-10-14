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

directory "/srv/photo_album/shared/tmp" do
  action :create
  owner 'deploy'
  group 'deploy'
  mode '0755'
end

directory "/srv/photo_album/shared/tmp/pids" do
  action :create
  owner 'deploy'
  group 'deploy'
  mode '0755'
end

directory "/srv/photo_album/shared/tmp/sockets" do
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

directory "/srv/photo_album/shared/log" do
  action :create
  owner 'deploy'
  group 'deploy'
  mode '0755'
end

package "libmagickwand-dev"
package "nodejs"
