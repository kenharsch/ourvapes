# VapeRater Developer Info

This readme is not meant to be read by the public since this project is currently not open source.

Since our app nows that it uses Solr indexing, it will not allow to do any database changes
without Solr running. Trying it results in Errno::ECONNREFUSED: Connection refused` and an SQL
rollback, undoung the started changes.

In particular this causes most tests to fail because they try to add or change DB entries.

Trying to use the search box without Solr running causes the same error.


Thus, before doing anything which changes the DB or uses fulltext search, we need
```
rake sunspot:solr:start
```

After that we can start and stop the server, console or whatever else we want. Solr runs in the
background until we call
```
rake sunspot:solr:stop
```

Sometimes, after testing or seeding the indices become broken, not always though - I will
investigate more on this ASAP. **Having Solr running** this can always be repaired by
```
rake sunspot:solr:reindex
```


## Repairing Solr / Sunspot

1) Delete the solr folder
2) Delete the config/sunspot.yml
3) run the following
```
rails generate sunspot_rails:install
```

## Testing

According to stackoverflow we should use `bundle exec` if we use bundler to manage gem
dependencies, which we do. Also I had some cases where tests failed without the `bundle exec`
but did not fail with it.


run a single test file
```
bundle exec ruby -I test test/models/product_blackbox_test.rb
```

The Solr calls shown above start the Solr server for the development environment, especially for
the development DB. This won't work with tests which use the test DB in test environment.
Instead we need to start the Solr server in the test environment. E.g. running the full-text search
test could be done by
```
RAILS_ENV=test rake sunspot:solr:start
bundle exec ruby -I test test/models/product_search_test.rb
RAILS_ENV=test rake sunspot:solr:stop
```

Similarly, running all tests would be
```
RAILS_ENV=test rake sunspot:solr:start
rake test:prepare
rake test
RAILS_ENV=test rake sunspot:solr:stop
```

## Running in development mode

There should be some configuration to run solr automatically and I will try to set this ASAP.
For now, e.g. to run our app with fulltext search functionality, we have to do
```
rake sunspot:solr:start
rails s
sunspot:solr:stop
```