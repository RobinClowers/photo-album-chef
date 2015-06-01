name 'base'
description 'Rails infrastructure'
run_list(
  'recipe[apt]',
  'recipe[photo-album::base]',
  'recipe[sudo]',
  'recipe[postgresql::client]',
  'recipe[ruby-install::install]',
  'recipe[ssh-keys]',
)

default_attributes({
  authorization: {
    sudo: {
      groups: ["admin", "wheel", "sysadmin"],
      users: ["admin", "deploy"],
      passwordless: "true"
    }
  },
  "ruby-install" => {
    rubies: [
      {
        ruby: "ruby 2.2.2",
        gems: [
          {
            name: "bundler",
            version: "1.5.3"
          },
        ]
      }
    ]
  },
  ssh_keys: {
    deploy: "deploy",
  },
})
