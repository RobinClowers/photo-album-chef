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

puma_config "photo_album" do
  directory "/srv/photo_album"
  bind "unix:///srv/photo_album/shared/tmp/sockets/puma.sock"
  environment 'staging'
  monit true
  logrotate true
  thread_min 0
  thread_max 16
  workers 2
end

postgresql_database node['photo_album']['database_name'] do
  connection(
    host:     "localhost",
    port:     node["postgresql"]["config"]["port"],
    username: 'postgres',
    password: node['postgresql']['password']['postgres']
  )
end

postgresql_database_user 'photo_album' do
  password   'asdfasdf'
  action     :create
  connection(
    host:     'localhost',
    port:     node['postgresql']['config']['port'],
    username: 'postgres',
    password: node['postgresql']['password']['postgres']
  )
end

file "/etc/nginx/sites-enabled/photo_album" do
  owner 'deploy'
  group 'deploy'
  mode '0755'
  content <<-CONFIG
    upstream photo_album {
      server unix:///srv/photo_album/shared/tmp/sockets/puma.sock;
    }

    server {
      listen 80;
      server_name www.photos.robinclowers.com photos.robinclowers.com;

      keepalive_timeout 5;

      root /srv/photo_album/current/public;

      access_log /var/log/nginx/nginx.access.log;
      error_log /var/log/nginx/nginx.error.log info;

      if (-f $document_root/maintenance.html) {
        rewrite  ^(.*)$  /maintenance.html last;
        break;
      }

      location ~ ^/(assets)/  {
        root /srv/photo_album/current/public;
        expires max;
        add_header  Cache-Control public;
      }

      location / {
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $http_host;

        if (-f $request_filename) {
          break;
        }

        if (-f $request_filename/index.html) {
          rewrite (.*) $1/index.html break;
        }

        if (-f $request_filename.html) {
          rewrite (.*) $1.html break;
        }

        if (!-f $request_filename) {
          proxy_pass http://photo_album;
          break;
        }
      }

      # Now this supposedly should work as it gets the filenames
      # with querystrings that Rails provides.
      # BUT there's a chance it could break the ajax calls.
      location ~* \.(ico|css|gif|jpe?g|png)$ {
         expires max;
         break;
      }

      location ~ ^/javascripts/.*\.js$ {
         expires max;
         break;
      }

      # Error pages
      # error_page 500 502 503 504 /500.html;
      location = /500.html {
        root /srv/photo_album/current/public;
      }
    }
CONFIG
end

package "libmagickwand-dev"
package "nodejs"
