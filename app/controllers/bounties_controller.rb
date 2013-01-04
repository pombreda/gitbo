class BountiesController < ApplicationController
  # GET /bounties
  # GET /bounties.json
  def claim
    issue = Issue.find_by_repo_name_and_git_number(params[:repo_name], params[:git_number])
    repo_url = "#{params[:owner_name]}/#{params[:repo_name]}"

    if issue.bounty_verification #&& issue.closed?
      if current_user.check_bounty_winner(repo_url, issue)
        issue.credit_bounties_to(current_user.id)
        flash[:notice] = 'Congratulations! We will reach you shortly with instructions to claim your bounty'
        ####send an email to gitbounty@gmail.com notifying of a successful claim
      else
        flash[:error] = 'our records show you did not close this issue'
      end
    else
      flash[:error] = 'This does not match our records'
    end
    redirect_to :back
  end

  def index
    @bounties = Bounty.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bounties }
    end
  end

  # GET /bounties/1
  # GET /bounties/1.json
  def show
    @bounty = Bounty.find(params[:id])


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bounty }
    end
  end

  # GET /bounties/new
  # GET /bounties/new.json
  def new
    @issue = Issue.find_by_git_number(params[:git_no])
    @bounty = Bounty.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bounty }
      format.js
    end
  end

  # GET /bounties/1/edit
  def edit
    @bounty = Bounty.find(params[:id])
    @issue = @bounty.issue
  end

  # POST /bounties
  # POST /bounties.json
  def create
    repo = Repo.find_by_owner_name_and_name(params[:owner], params[:repo])
    git_number = params[:git_no]
    issue = Issue.find_by_git_number_and_repo_id(git_number, repo.id)
    price = params[:price]

    @bounty = issue.add_bounty(current_user, price)

    respond_to do |format|
      if @bounty
        format.html { redirect_to owner_repo_gitnumber_path(@bounty.issue.repo_owner, @bounty.issue.repo_name, @bounty.issue.git_number), notice: 'Bounty was successfully created.' }
        format.json { render json: @bounty, status: :created, location: @bounty }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @bounty.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bounties/1
  # PUT /bounties/1.json
  def update
    @bounty = Bounty.find(params[:id])

    respond_to do |format|
      if @bounty.update_attributes(params[:bounty])
        format.html { redirect_to "/#{@bounty.issue.repo_owner}/#{@bounty.issue.repo_name}/issues/#{@bounty.issue.git_number}", notice: 'Bounty was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @bounty.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bounties/1
  # DELETE /bounties/1.json
  def destroy
    @bounty = Bounty.find(params[:id])
    @bounty.destroy

    respond_to do |format|
      format.html { redirect_to bounties_url }
      format.json { head :no_content }
    end
  end
end
