module IssuesHelper

  def link_to_new_bounty_for(issue, opts = {})
    link_to "Issue Bounty", new_issue_bounty_path(issue.repo.owner_name, issue.repo.name, issue.git_number), :class => "btn btn-success btn-small", id: "new_link", remote: true
   end

  def repo_owner_vote?(issue)
    return true if UserVote.owner_difficulty_rating?(issue)
  end

  def has_the_owner_voted?(issue)
    repo_owner_vote?(issue) && UserVote.owner_rating(issue) != 0
  end

  def have_users_voted?(issue)
    UserVote.user_average_difficulty(issue) != 0.0
  end

end
