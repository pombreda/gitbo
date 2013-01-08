require 'sidekiq/web'

Gitbo::Application.routes.draw do

    #stripe charges
  resources :charges


  ### sidekiq monitoring
  mount Sidekiq::Web, at: "/sidekiq"
  
  post '/:owner/:repo/issues/:git_no/bounty/' => "bounties#create", :as => :create_issue_bounty

  get '/:owner/:repo/issues/:git_no/bounty/new' => "bounties#new", :as => :new_issue_bounty

  get '/:owner/:repo/issues/:git_no/bounty/:id/edit' => "bounties#edit", :as => :edit_issue_bounty

  resources :bounties, :except => [:new, :show, :create]
  resources :comments
  resources :users
  
  #authentication through github
  match '/auth/:provider/callback' => 'sessions#create'
  match '/auth/failure' => 'sessions#failure'
  
  get '/signout' => "sessions#destroy", :as => :signout

  get "/:owner/:repo/issues" => "repos#show"

  #voting
  put '/issues/:id/vote/:direction' => 'issues#vote', :as => :vote_issue
  #difficulty
  put '/issues/:id/rating' => 'issues#difficulty', :as => :difficulty_rating
  
  #owner endorsment
  put '/issues/:id/endorsement/:direction' => 'issues#endorsement', :as => :owner_endorsement

  resources :repos do
    #this needs to be cleaned up. Most of these have been depreciated.
    resources :issues, :only => [:index, :delete] # will eventually remove delete
  end

  #bounty claming
  post '/bounties/claim' => 'bounties#claim', :as => :bounty_claim

  #issues
  get "/issues" => "issues#index"

  get "/:owner/:repo/issues/:git_number" => 'issues#show', :as => :owner_repo_gitnumber
  get "/:owner/*repo" => 'repos#show', :as => :owner_repo, :format => false
  get "/:owner" => 'users#show', :as => :owner_repos


  root :to => 'static#index'

  end
