module IssuesHelper

  def link_to_new_bounty_for(issue, opts = {})
    link_to "Issue Bounty", new_issue_bounty_path(issue.repo_owner, issue.repo_name, issue.git_number), :class => "btn btn-success btn-small", id: "new_link", remote: true
  end

  def link_to_create_bounty_for(issue, opts = {})
    link_to "Create it", create_issue_bounty_path(issue.repo_owner, issue.repo_name, issue.git_number), :class => "btn btn-success btn-small", id: "create_link", remote: true
  end

  def repo_owner_vote?(issue)
    return true if UserVote.owner_difficulty_rating?(issue)
  end

  def has_the_owner_rated?(issue)
    repo_owner_vote?(issue) && UserVote.owner_rating(issue) != 0
  end

  def have_users_rated?(issue)
    return true unless (issue.avg_difficulty == 0)
  end

  def both_owner_and_user_rated(issue)
    have_users_rated?(issue) && has_the_owner_rated?(issue)
  end

  def users_rated_but_no_owner(issue)
    have_users_rated?(issue) && !has_the_owner_rated?(issue)
  end

  def owner_rated_but_no_users(issue)
    !have_users_rated?(issue) && has_the_owner_rated?(issue)
  end

  def neither(issue)
    !have_users_rated?(issue) || !has_the_owner_rated?(issue)
  end
end
