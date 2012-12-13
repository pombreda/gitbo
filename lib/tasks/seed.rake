desc "Create a bunch of seed data for repos"

task :seed_demo_repos => [:environment, :clear_repos_and_issues] do

  repo = Repo.new(:owner_name => "intridea", :name => "omniauth")
  repo.save
  RepoWorker.perform_async(repo.id)
  puts "Just sent repo #{repo.id} - #{repo.name} to worker"

  repo = Repo.new(:owner_name => "jnicklas", :name => "capybara")
  repo.save
  RepoWorker.perform_async(repo.id)
  puts "Just sent repo #{repo.id} - #{repo.name} to worker"

  repo = Repo.new(:owner_name => "arsduo", :name => "koala")
  repo.save
  RepoWorker.perform_async(repo.id)
  puts "Just sent repo #{repo.id} - #{repo.name} to worker"
  
  repo = Repo.new(:owner_name => "rspec", :name => "rspec-rails")
  repo.save
  RepoWorker.perform_async(repo.id)
  puts "Just sent repo #{repo.id} - #{repo.name} to worker"
  
  repo = Repo.new(:owner_name => "pengwynn", :name => "octokit")
  repo.save
  RepoWorker.perform_async(repo.id)
  puts "Just sent repo #{repo.id} - #{repo.name} to worker"

  repo = Repo.new(:owner_name => "mperham", :name => "sidekiq")
  repo.save
  RepoWorker.perform_async(repo.id)
  puts "Just sent repo #{repo.id} - #{repo.name} to worker"

  repo = Repo.new(:owner_name => "defunkt", :name => "resque")
  repo.save
  RepoWorker.perform_async(repo.id)
  puts "Just sent repo #{repo.id} - #{repo.name} to worker"

  repo = Repo.new(:owner_name => "joshrowley", :name => "dummyrepo")
  repo.save
  RepoWorker.perform_async(repo.id)
  puts "Just sent repo #{repo.id} - #{repo.name} to worker"

  # repo = Repo.new(:owner_name => "ajonas04", :name => "dummy")
  # repo.save
  # RepoWorker.perform_async(repo.id)
  # puts "Just sent repo #{repo.id} - #{repo.name} to worker"
  # issue = Issue.new(:title => 'dummy1', :git_number => '1', :repo_id => 9, 
  # :repo_name => 'dummy', :repo_owner 'ajoans04', :state => 'open' )

end


task :clear_repos_and_issues => [:environment] do
  puts "Deleting all Repos and Issues...."

  Repo.delete_all
  Issue.delete_all
  Bounty.delete_all
  Comment.delete_all
  UserVote.delete_all
end
