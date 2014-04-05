[![Code Climate](https://codeclimate.com/github/personinma/VapeRater.png)](https://codeclimate.com/github/personinma/VapeRater)
# VapeRater Developer Info

This readme is not meant to be read by the public since this project is currently not open source.

## PostgresSQL

Most of this information is from
http://www.amberbit.com/blog/2014/2/4/postgresql-awesomeness-for-rails-developers/ and
https://www.digitalocean.com/community/articles/how-to-setup-ruby-on-rails-with-postgres

### Installation

```
$ echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" | sudo tee -a /etc/apt/sources.list
$ wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
$ sudo apt-get update
$ sudo apt-get install postgresql-9.3 libpq-dev
$ sudo su - postgres
$ create role vaperater with createdb login password 'password1'
$ exit
```


### Acting as user _postgres_ on your OS

PostgresSQL uses its own user management system and calls users _roles_. It comes with one
default role _postgres_. In order to login to the Postgres server in user role _postgres_ (e.g. to
create other roles and new databases) we need to be logged in with username _postgres_ on our
OS (Mac OS, Linux, Windows).

Fortunately the installation above (or Ubuntu per default, I'm not sure) creates a user _postgres_
on our system. We just have to login as such:
```
$ sudo su - postgres
```

To get back to your original login you have to exit the _postgres_ login:
```
$ exit
```


### Interacting with Postgres DB

Once logged in as _postgres_ on your OS you can connect to the postgres server via
```
$ psql
```

which should change the terminal to
```
postgres=#
```

Now you can use `\help` to show all available commands and `\help [command]` for viewing the
syntax of a particular command. E.g. to see the syntax of `CREATE ROLE` use
```
postgres=# \help CREATE ROLE
```

To leave the Postgres DB shell use
```
postgres=# \q
```

In contrary to commands like `\q` and `\help` the database manipulating commands like
`CREATE ROLE` are entered **without a leading `\` and end with `;`**, e.g.
```
postgres=# create role vaperater with createdb;
```

#### Pitfall 1: everything is turned to lowercase

Per deafult Postgres turns all the netries into lowercase. Therefore it's probably convenient to use
lowercase / snake case for everything like role name and database name. However if you happen
to create a role called VapeRater (not lowercase) and then execute
```
postgres=# create role VapeRater with createdb;
```
you well get a `ERROR:  role "vaperater" does not exist` (notice: _vaperater_ instead of
_VapeRater_ as you entered it). Although the role VapeRater might exist:
```
postgres=# SELECT rolname FROM pg_roles;
  rolname
-----------
 postgres
 VapeRater
 vagrant
(3 rows)
```

In order to delete the role VapeRater you have to use qutations:
```
postgres=# DROP ROLE "VapeRater";
DROP ROLE
postgres=# SELECT rolname FROM pg_roles;
 rolname
----------
 postgres
(1 row)
```




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


### RSolr::Error::Http: RSolr::Error::Http - 404 Not Found

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
