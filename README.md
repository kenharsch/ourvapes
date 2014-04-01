# VapeRater Developer Info

this readme is not meant to be read by the public since this project is currently not open source

## Testing

I am not sure if the `bundle exec` is necessary but stackoverflow says it should be used if we
use bundler to manage gem dependencies, which we do


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