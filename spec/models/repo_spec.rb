require 'spec_helper'

describe Repo do
    
  context "it should import info from Github and create repo" do

    context ".create_from_github" do

      xit "should persist a repo from Github" do
        repo = Repo.create_from_github("lockitron", "selfstarter")

        Repo.find_by_name("selfstarter").should be_true
        Repo.owner_name.should == "lockitron"
        # repo.open_issues.should == 2
      end

    end 

    context "list_all_issues" do

      xit "should return all issues from each repo" do
        repo = Repo.create_from_github("lockitron", "selfstarter")
        issue_1 = Issue.create_from_github("lockitron", "selfstarter", 6)
        issue_2 = Issue.create_from_github("lockitron", "selfstarter", 7)
        issue_3 = Issue.create_from_github("lockitron", "selfstarter", 13)

        repo.issues.count.should == 3
      end

    end
  end

end
