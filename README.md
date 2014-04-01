# VapeRater Developer Info

this readme is not meant to be read by the public since this project is currently not open source

## Testing

### run a single test file
e.g. the file `test/models/product_blackbox_test.rb`
```
	bundle exec ruby -I test test/models/product_blackbox_test.rb
	I am not sure if the “bundle exec” is necessary but stackoverflow says it should be used if we use
	bundler to manage gem dependencies, which we do
```

### running the full-text search test
```
	RAILS_ENV=test rake sunspot:solr:start
	bundle exec ruby -I test test/models/product_search_test.rb
	RAILS_ENV=test rake sunspot:solr:stop
```

### running all tests
```
	RAILS_ENV=test rake sunspot:solr:start
	rake test:prepare
	rake test
	RAILS_ENV=test rake sunspot:solr:stop
```