name 'web'
description 'Rails server'
run_list(
  'role[base]',
  'role[database]',
  'recipe[puma]',
  'recipe[nginx]',
  'recipe[photo-album]',
)

default_attributes({
  nginx: {
    default_site_enabled: false,
  },
  "puma" => {
    rubygems_location: "/opt/rubies/ruby-2.1.2/bin/gem"
  },
})
