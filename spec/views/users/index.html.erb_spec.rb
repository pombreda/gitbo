require 'spec_helper'

describe "users/index" do
  before(:each) do
    assign(:users, [
      stub_model(User,
        :provider => "Provider",
        :url => "Url"
      ),
      stub_model(User,
        :provider => "Provider",
        :url => "Url"
      )
    ])
  end

  it "renders a list of users" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Provider".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
  end
end
