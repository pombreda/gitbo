require 'spec_helper'

describe Repo do
    
  context "it should import info from Github and create repo" do

    context ".create_from_github" do

      it "should persist a repo from Github" do
        repo = Repo.create_from_github("intridea", "omniauth")

        Repo.find_by_name("omniauth").should be_true
        Repo.find_by_owner_name("intridea").owner_name.should == "intridea"
        repo.watchers.should == 3422
      end

    end 

    context ".list_all_issues" do

      it "should return all issues from each repo" do
        issue_1 = Issue.create_from_github("intridea", "omniauth", 645)
        issue_2 = Issue.create_from_github("intridea", "omniauth", 642)
        issue_3 = Issue.create_from_github("intridea", "omniauth", 640)
        repo = Repo.create_from_github("intridea", "omniauth")

        repo.list_all_issues.count.should == 3

      end

    end
  end

end
