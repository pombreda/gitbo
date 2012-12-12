require 'spec_helper'

describe Issue do

  # context "it should import info from Github and create Issue" do

  #   context ".create_from_github" do

  #     xit "should persist an issue from Github" do
  #       issue = Issue.create_from_github("intridea", "omniauth", 645)

  #       Issue.find_by_git_number(645).should be_true
  #       Issue.find_by_title("TypeError on Ruby 1.8.7 - 0.3.0-stable branch").should be_true
  #       Issue.find_by_git_number(645).body.should include("OmniAuth::Strategies::SAML::AuthRequest")

  #     end

    context '.add_bounty' do

      it 'should add a bounty for that issue' do
        issue = create(:issue)
        user = create(:user)
        issue.add_bounty(user, 40)

        issue.should be_true
      end
    end

    context '.issue_open' do
      it 'should return false is the issue is closed' do
      issue = create(:issue)
      issue.state = 'closed'

      issue.open?.should be_false
      end
    end

    context '.popularity' do
      it 'popularity should return a positive number' do
        issue = create(:issue)
        issue.popularity.should be >= 0
      end
    end


    context '.popularity_github' do
      it 'should return a positive number' do
        issue = create(:issue)
        issue.popularity_github.should be >= 0
      end
    end


    context '.add_vote_by' do
      it 'should add one to the issues vote score' do
        issue = create(:issue)
        user = create(:user)
        expect {
        issue.add_vote_by(user, "downvote") }.to change(issue, :vote_count).by(-1)
      end
    end

  #   end
  # end
end
