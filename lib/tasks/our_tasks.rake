namespace :solr do
	task :test do
		system("RAILS_ENV=test rake sunspot:solr:start")
		system("rake test")
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