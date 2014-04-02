# VapeRater Developer Info

this readme is not meant to be read by the public since this project is currently not open source

## Testing

According to stackoverflow we should use `bundle exec` if we use bundler to manage gem
dependencies, which we do. Also I had some cases where tests failed without the `bundle exec`
but did not fail with it.


run a single test file
```
bundle exec ruby -I test test/models/product_blackbox_test.rb
```

run the full-text search test
```
RAILS_ENV=test rake sunspot:solr:start
bundle exec ruby -I test test/models/product_search_test.rb
RAILS_ENV=test rake sunspot:solr:stop
```

run all tests
```
RAILS_ENV=test rake sunspot:solr:start
rake test:prepare
rake test
RAILS_ENV=test rake sunspot:solr:stop
```

## Running in development mode

There should be some configuration to run solr automatically and I will try to set this ASAP.
For now it is
```
rake sunspot:solr:start
rails s
sunspot:solr:stop
```