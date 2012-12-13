require 'spec_helper'

describe Issue do

   let(:issue) { create(:issue) }
   let(:user) { create(:user) }

    describe '.add_bounty' do

      it 'should add a bounty for that issue' do
        issue.add_bounty(user, 40)
        issue.should be_true
      end
    end

    describe '.issue_open' do
      it 'should return false is the issue is closed' do
      
      issue.state = 'closed'

      issue.open?.should be_false
      end
    end

    describe '.popularity' do
      it 'popularity should return a positive number' do
        
        issue.popularity.should be >= 0
      end
    end


    describe '.popularity_github' do
      it 'should return a positive number' do
        
        issue.popularity_github.should be >= 0
      end
    end



    describe '.popularity' do
      it 'popularity should return a positive number' do
        
        issue.popularity.should be >= 0
      end
    end


  
    describe '.endorsement_by(approval)' do
    
        it 'should change the endorsement status positively' do
          issue.endorsement_by('endorsement')
          issue.owner_endorsement.should == 1
        end

        it 'should change the endorsement status negatively' do
          issue.endorsement_by('disapproval')
          issue.owner_endorsement.should == -1
        end
      
    end


    describe '.add_vote_by' do
      context 'changing a vote changes the issue vote count' do
        
        it 'upvote' do
          issue.add_vote_by(user, "upvote")
          issue.vote_count.should == 1
        end

        it 'downvote' do
          issue.add_vote_by(user, "downvote")
          issue.vote_count.should == -1
        end
      end
    end


    describe 'how a user voted' do
      before do
        @uv = UserVote.find_or_create_by_issue_id_and_user_id(issue.id, user.id)
      end
       
        context 'when upvoted' do
          before do 
            @uv.vote = 1
            @uv.save
          end

          it 'should be an upvote' do
            issue.how_user_voted(user).should == :upvote
          end

        end

    end


     describe '.add_difficulty' do
      it 'adding difficulty should recalc the
       difficulty rating of the issue' do
      
        uv = UserVote.find_or_create_by_issue_id_and_user_id(issue.id, user.id)
        rank = rand(1..5)

        issue.add_difficulty_by(user, rank)
        issue.avg_difficulty.should == rank
      end
    end



end
