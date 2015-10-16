include_recipe "photo-album::base"

postgresql_database node['photo_album']['database_name'] do
  connection(
    host:     "localhost",
    port:     node["postgresql"]["config"]["port"],
    username: 'postgres',
    password: node['postgresql']['password']['postgres']
  )
end

postgresql_database_user 'photo_album' do
  password   ChefVault::Item.load("postgres", "password")
  action     :create
  connection(
    host:     'localhost',
    port:     node['postgresql']['config']['port'],
    username: 'postgres',
    password: node['postgresql']['password']['postgres']
  )
end

backup_install node.name
backup_generate_config node.name
package "libxml2-dev"
package "libxslt1-dev"
gem_package "fog" do
  version "~> 1.4.0"
end

backup_generate_model "pg" do
  description "backup of postgres"
  backup_type "database"
  database_type "PostgreSQL"
  split_into_chunks_of 2048
  store_with({
    "engine" => "S3",
    "settings" => {
      "s3.access_key_id" => ChefVault::Item.load("s3", "access_key_id"),
      "s3.secret_access_key" => ChefVault::Item.load("s3", "access_key"),
      "s3.region" => "us-east-1",
      "s3.bucket" => "sample",
      "s3.path" => "/", "s3.keep" => 10
    }
  })
  options({
    "db.name" => "\"postgres\"",
    "db.username" => "\"photo_album\"",
    "db.password" => "\"#{ChefVault::Item.load("postgres", "password")}\"",
    "db.host" => "\"localhost\""
  })
  mailto "robin.clowers-pg-backup@gmail.com"
  action :backup
end
