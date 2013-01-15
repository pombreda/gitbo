class IssuesController < ApplicationController
  # GET /issues
  # GET /issues.json

  helper_method :repo_owner

  def vote
    @issue = Issue.find(params[:id])
    @issue.add_vote_by(current_user, params[:direction])
    @issue.save
    
    respond_to do |f|
      f.html {redirect_to :back}
      f.js {}
    end
  end

  def difficulty
    issue = Issue.find(params[:id])
    issue.add_difficulty_by(current_user, params[:rating])
    issue.save

    respond_to do |f|
      f.html {redirect_to :back}
      f.js { head :created }
    end
  end

  def endorsement
    issue = Issue.find(params[:id])
    issue.endorsement_by(params[:direction])
    issue.save
    redirect_to :back
  end

  def

  def repo_issues
    @repo = Repo.find_by_owner_name_and_name(params[:owner], params[:repo])
    @issues = @repo.issues
    
    render 'repos/issues/index'

    # respond_to do |format|
    #   format.html # index.html.erb
    #   format.json { render json: @issues }
    # end
  end

  def index
    @issues = Issue.search(params[:search])#search_and_filter_open_issues(params)
    @repo = Repo.new
    1.times { @repo.issues.build}

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @issues }
      format.js {}
    end
  end

  # GET /issues/1
  # GET /issues/1.json
  def show
    repo = Repo.find_by_owner_name_and_name(params[:owner], params[:repo])

    @issue = Issue.find_by_repo_id_and_git_number(repo.id, params[:git_number])

    if !@issue
      flash[:error] = "There is no issue number #{params[:git_number]} for #{params[:owner]}/#{params[:repo]}"
      redirect_to :action => "index"
    else
      @difficulty = @issue.retrieve_difficulty(current_user) if current_user
      
      if current_user
        RefreshIssuesWorker.perform_async(@issue.id, current_user.token)
      end
      
      # if @issue.updated?(@issue.repo.octokit_id, @issue.git_number, octokit_client.client)
      #   RefreshIssuesWorker.perform_async(@issue.id, current_user.token)
      #   flash[:notice] = "Updating issue from Github, please refresh"
      # end 

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @issue }
      end
    end
  end

  # GET /issues/new
  # GET /issues/new.json
  def new
    @issue = Issue.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @issue }
    end
  end

  # GET /issues/1/edit
  def edit
    @issue = Issue.find(params[:id])
  end

  # POST /issues
  # POST /issues.json
  def create
    @issue = Issue.create_from_github(params[:owner_name, :name, :git_number])

    respond_to do |format|
      if @issue.save
        format.html { redirect_to @issue, notice: 'Issue was successfully created.' }
        format.json { render json: @issue, status: :created, location: @issue }
      else
        format.html { render action: "new" }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /issues/1
  # PUT /issues/1.json
  def update
    @issue = Issue.find(params[:id])

    respond_to do |format|
      if @issue.update_attributes(params[:issue])
        format.html { redirect_to @issue, notice: 'Issue was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /issues/1
  # DELETE /issues/1.json
  def destroy
    @issue = Issue.find(params[:id])
    @issue.destroy

    respond_to do |format|
      format.html { redirect_to issues_url }
      format.json { head :no_content }
    end
  end


private

  def repo_owner
    return true if current_user.nickname == @issue.repo_owner
  end

  
end
