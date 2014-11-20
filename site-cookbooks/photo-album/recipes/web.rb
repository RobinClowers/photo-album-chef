include_recipe "photo-album::base"

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

      location ~ ^/(assets)/  {
        expires max;
        add_header  Cache-Control public;

        add_header ETag "";
        break;
      }

      location / {
        proxy_pass  http://photo_album;
        proxy_redirect     off;
        proxy_read_timeout 5m;

        proxy_set_header   Host             $host;
        proxy_set_header   X-Real-IP        $remote_addr;
        proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;
        proxy_set_header   X-Forwarded-Proto  http;
      }

      # Error pages
      # error_page 500 502 503 504 /500.html;
      location = /500.html {
        root /srv/photo_album/current/public;
      }

      try_files $uri @photo_album;
    }
CONFIG
end

file "/etc/nginx/sites-enabled/robinclowers.com" do
  owner 'deploy'
  group 'deploy'
  mode '0755'
  content <<-CONFIG
    server {
      listen 80 default_server;
      server_name www.robinclowers.com robinclowers.com;
      root /srv/robinclowers.com;
    }
CONFIG
end
