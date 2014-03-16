name 'web'
description 'Rails server'
run_list(
  'recipe[ruby-install::install]',
  'recipe[nginx]',
  'recipe[puma]'
)

default_attributes({
  "ruby-install" => {
    rubies: [
      {
        ruby: "ruby 2.1.1",
        reinstall: false,
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
  },
  "puma" => {
    rubygems_location: "/opt/rubies/ruby-2.1.1/bin"
  }
})
