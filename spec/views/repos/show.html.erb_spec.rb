require 'spec_helper'

describe "repos/show" do
  before(:each) do
    @repo = assign(:repo, stub_model(Repo))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
