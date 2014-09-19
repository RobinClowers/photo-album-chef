name 'web'
description 'Rails server'
run_list(
  'recipe[apt]',
  'recipe[ruby-install::install]',
  'recipe[puma]',
  'recipe[postgresql::server]',
  'recipe[database::postgresql]',
  'recipe[nginx]',
  'recipe[photo-album]',
  'recipe[ssh-keys]',
)

default_attributes({
  authorization: {
    sudo: {
      groups: ["admin", "wheel", "sysadmin"],
      users: ["admin"],
      passwordless: "true"
    }
  },
  nginx: {
    default_site_enabled: false,
  },
  "ruby-install" => {
    rubies: [
      {
        ruby: "ruby 2.1.2",
        gems: [
          {
            name: "bundler",
            version: "1.5.3"
          },
        ]
      }
    ]
  },
  "puma" => {
    rubygems_location: "/opt/rubies/ruby-2.1.2/bin/gem"
  },
  ssh_keys: {
    deploy: "deploy",
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
