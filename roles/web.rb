name 'web'
description 'Rails server'
run_list(
  'role[base]',
  'recipe[puma]',
  'recipe[postgresql::server]',
  'recipe[database::postgresql]',
  'recipe[redis::install_from_package]',
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
  postgresql: {
    password: {
      postgres: "d4dd6397cf55a4507874c3864f092a8c"
    },
  },
})
override_attributes({
  postgresql: {
    pg_hba: [
      {
        type: "local",
        db: "all",
        user: "postgres",
        method: "ident",
      },
      {
        type: "local",
        db: "all",
        user: "all",
        method: "md5",
      },
      {
        type: "host",
        db: "all",
        user: "all",
        addr: "127.0.0.1/32",
        method: "md5",
      },
    ]
  },
})
