class {{puppetName}}::profile::db (
) {

  if defined (Class['::mysql::server']) == false {
    class { '::mysql::server':
      databases   => {
        '{{database.name}}'  => {
          ensure  => 'present',
          charset => 'utf8',
        },
      },
      grants => {
        '{{database.username}}@localhost/{{database.name}}.*' => {
          ensure     => 'present',
          options    => ['GRANT'],
          privileges => ['SELECT', 'INSERT', 'CREATE', 'UPDATE', 'DELETE'],
          table      => '{{database.name}}.*',
          user       => '{{database.username}}@localhost',
        },
      },
      remove_default_accounts => true,
      users => {
        '{{database.username}}@localhost' => {
          ensure                   => 'present',
          max_connections_per_hour => '0',
          max_queries_per_hour     => '0',
          max_updates_per_hour     => '0',
          max_user_connections     => '0',
          password_hash            => '*AC57754462B6D4C373263062D60EDC6E452E574D',
        }
      }
    }
  }

}
