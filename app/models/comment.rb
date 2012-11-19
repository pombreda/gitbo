class Comment < ActiveRecord::Base
  attr_accessible :body, :git_number, :git_update_at, :issue_id, :owner_image, :owner_name
  belongs_to :issue

  def self.create_from_github( issue, comment)

    issue.comments.build( :body => comment.body,
                          :git_update_at => comment.updated_at.to_datetime,
                          :git_number => comment.id,
                          :owner_name => comment.user.login,
                          :owner_image => comment.user.avatar_url)
    
    issue.save 
  end

  def time_ago
    from_time = Time.now
    distance_of_time_in_words
  end

  def repo
    "#{repo_owner_name}/#{repo_name}"
  end

  private

  def repo_owner_name
    self.issue.repo.owner_name
  end

  def repo_name
    self.issue.repo.name
  end

end
