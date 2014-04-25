namespace :solr do
	task :test, :single_test_path do |t, args|
		system("RAILS_ENV=test rake sunspot:solr:start")

		system("rake test:prepare")

		test_path = args[:single_test_path]
		if (test_path.blank?)
			system("rake test")
		else
			system("bundle exec ruby -I test test/#{test_path}")
		end

		system("RAILS_ENV=test rake sunspot:solr:stop")
	end

	task :s do
		system("rake sunspot:solr:start")
		system("rails s")
		system("rake sunspot:solr:stop")
	end

	task :c do
		system("rake sunspot:solr:start")
		system("rails c")
		system("rake sunspot:solr:stop")
	end
end

# start in production mode
task :p do
	system("rake assets:precompile")
	system("rails s -e production")
end