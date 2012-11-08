require 'spec_helper'

describe "repos/index" do
  before(:each) do
    assign(:repos, [
      stub_model(Repo),
      stub_model(Repo)
    ])
  end

  it "renders a list of repos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
