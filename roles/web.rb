name 'web'
description 'Rails server'
run_list(
  'recipe[ruby-install::install]',
  'recipe[nginx]',
  'recipe[puma]',
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
})
