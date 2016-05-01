class {{puppetName}}::role::prod {
  include {{puppetName}}::profile::db
  include {{puppetName}}::profile::httpd
}
