name 'web'
description 'Rails server'
run_list(
  'recipe[ruby-install::install]',
  'recipe[puma]',
  'recipe[photo-album]',
  'recipe[nginx]',
  'recipe[ssh-keys]',
  'recipe[postgresql::server]',
  'recipe[database::postgresql]',
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
        ruby: "ruby 2.1.1",
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
    rubygems_location: "/opt/rubies/ruby-2.1.1/bin/gem"
  },
  ssh_keys: {
    deploy: "deploy",
  },
  postgresql: {
    password: {
      postgres: "d4dd6397cf55a4507874c3864f092a8c"
    }
  },
})
