name 'database'
description 'Postgres and Redis servers'
run_list(
  'role[base]',
  'recipe[postgresql::server]',
  'recipe[database::postgresql]',
  'recipe[redisio]',
  'recipe[redisio::install]',
  'recipe[redisio::enable]',
)

default_attributes({
  postgresql: {
    password: {
      postgres: "d4dd6397cf55a4507874c3864f092a8c"
    },
  },
  redisio: {
    version: '2.8.24',
    safe_install: true,
    servers: [
      { port: '6379', address: '0.0.0.0' },
    ]
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
