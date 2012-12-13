require 'spec_helper'

describe Repo do
    
  let(:repo) { create(:repo) }

  describe '.bounty_total' do
    xit 'should increase as the issue bounties increase' do
      issue = create(:issue)
      user = create(:user)
      expect { issue.add_bounty(user, 40) }.to change{repo.bounty_total}.by(40)
    end
  end


end
