# VapeRater Developer Info

This readme is not meant to be read by the public since this project is currently not open source.

## General

### delete vs. destroy

**In short:** Never use `delete` or `delete_all`, instead use `destroy` and `destroy_all`.

**Ratoinale:** The former two act directly on the database, ignoring all our settings in the models,
causing inconsistent dependencies and broken fulltext search indices. Imagine we have a `Wick`
object `w` and an associated `WickDet` object `w.details`. Calling `w.delete` would delete `w`
from the `prdocucts` table and leave the `WickDet` object in the `wick_dets` table with a _nil_
as foreign key. In contrary `w.destroy` would execute all the `dependent`, `before_validation`,
and `after_save` methods, causinfg the delete forwarding to the `WickDet` object as well as
the update of the Solr indices.


### Our app needs a running Solr instance

Since our app knows that it uses Solr indexing, it will not allow to do any database changes
without Solr running. Trying it results in `Errno::ECONNREFUSED: Connection refused` and an SQL
rollback, undoing the started changes.

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


## Repairing Solr


### Wrong search results

Sometimes, after testing or seeding, the indices become broken, not always though - I will
investigate more on this ASAP. **Having Solr running** this can always be repaired by
```
rake sunspot:solr:reindex
```


### RSolr::Error::Http - 404

Sometimes Solr fails to store the process id of a started Solr instance. Thus it claims not to
run at all when calling `rake sunspot:solr:stop`. This causes a `RSolr::Error::Http - 404` error.
To fix that

1) kill all solr processes manually using
```
ps aux | grep solr
```
for each shown process look at the PID column and do
```
kill -9 12345
```
where `12345` stands for the PID of the process to be killed

2) Delete the VapeRater/solr folder

3) Run Solr again
```
rake sunspot:solr:start
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