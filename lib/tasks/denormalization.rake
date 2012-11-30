namespace :denormalize do
  task :bounties => :environment do
    Issue.find_each do |issue|
      issue.bounty_total = issue.recalculate_bounty_total
      issue.save
    end
  end
end