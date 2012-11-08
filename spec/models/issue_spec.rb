require 'spec_helper'

describe Issue do

  context "it should import info from Github and create Issue" do

    context ".create_from_github" do

      it "should persist an issue from Github" do
        issue = Issue.create_from_github("intridea", "omniauth", 645)

        Issue.find_by_git_number(645).should be_true
      end

    end
  end
end
