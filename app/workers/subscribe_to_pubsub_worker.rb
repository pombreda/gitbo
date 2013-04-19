class SubscribeToPubsub
  include Sidekiq::Worker

  def perform(repo, count)
    
    hook_url = "http://requestb.in/1gmjod91" 
    #this will be the callback it the future "http://coil.io/hook/#{project.key}"

    current_user.client.subscribe(
      "https://github.com/#{repo.name}/#{repo.owner_name}/events/push",
      hook_url)

    puts 'you subscribed'

  end

end