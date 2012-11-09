desc "Create a bunch of seed data for repos"

task :seed_repos_and_issues => [:environment, :clear_repos_and_issues] do
  # Build Song Off Artist
  # Given a Song called R.E.S.P.E.C.T
  # build the Aretha Franklin Artist
  repo = Repo.create_from_github("intridea", "omniauth")
  puts "Just created repo #{repo.id} - #{repo.name}"

  repo = Repo.create_from_github("jnicklas", "capybara")
  puts "Just created repo #{repo.id} - #{repo.name}"

  repo = Repo.create_from_github("arsduo", "koala")
  puts "Just created repo #{repo.id} - #{repo.name}"
  
  repo = Repo.create_from_github("rspec", "rspec-rails")
  puts "Just created repo #{repo.id} - #{repo.name}"
  
  repo = Repo.create_from_github("pengwynn", "octokit")
  puts "Just created repo #{repo.id} - #{repo.name}"


end

task :clear_repos_and_issues => [:environment] do
  puts "Deleting all Repos and Issues...."

  Repo.delete_all
  Issue.delete_all
end
