class ReposController < ApplicationController
  # GET /repos
  # GET /repos.json

  rescue_from Octokit::NotFound, :with => :repo_not_found

  def index
    @repos = Repo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @repos }
    end
  end

  # GET /repos/1
  # GET /repos/1.json
  def show

    if params[:owner]
      @repo = Repo.find_by_owner_name(params[:owner])
    else
      @repo = Repo.find(params[:id])
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @repo }
    end
  end

  # GET /repos/new
  # GET /repos/new.json
  def new
    @repo = Repo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @repo }
    end
  end

  # GET /repos/1/edit
  def edit
    @repo = Repo.find(params[:id])
  end

  # POST /repos
  # POST /repos.json
  def create

    @repo = GithubWorker.perform_async(params[:repo][:owner_name], params[:repo][:name])

    redirect_to :root, notice: 'Your job is being processed, please check back shortly'
  
   respond_to do |format|
      if @repo.save
        format.html { redirect_to @repo, notice: 'Repo was successfully created.' }
        format.json { render json: @repo, status: :created, location: @repo }
      else
        format.html { render action: "new" }
        format.json { render json: @repo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /repos/1
  # PUT /repos/1.json
  def update
    @repo = Repo.find(params[:id])

    respond_to do |format|
      if @repo.update_attributes(params[:repo])
        format.html { redirect_to @repo, notice: 'Repo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @repo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /repos/1
  # DELETE /repos/1.json
  def destroy
    @repo = Repo.find(params[:id])
    @repo.destroy

    respond_to do |format|
      format.html { redirect_to repos_url }
      format.json { head :no_content }
    end
  end

  private

  def repo_not_found
    flash[:error] = "Repository not found. Please try again."
    redirect_to :back
  end

end
