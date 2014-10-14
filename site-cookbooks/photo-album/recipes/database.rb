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
  password   'asdfasdf'
  action     :create
  connection(
    host:     'localhost',
    port:     node['postgresql']['config']['port'],
    username: 'postgres',
    password: node['postgresql']['password']['postgres']
  )
end
