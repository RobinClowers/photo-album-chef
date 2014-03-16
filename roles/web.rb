name 'web'
description 'Rails server'
run_list(
  'recipe[ruby-install::install]',
  'recipe[nginx]'
)

default_attributes({
  "ruby-install" => {
    rubies: [
      {
        ruby: "ruby 2.1.1",
        reinstall: true,
        gems: [
          {
            name: "bundler",
            version: "1.5.3"
          },
          {
            name: "puma",
            version: "2.8.1"
          }
        ]
      }
    ]
  }
})
