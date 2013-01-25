require 'spec_helper'

describe "topic request" do
  it "prevents member from creating a sticky topic" do
    user = create(:user, admin: false, password: 'secret')
    post sessions_path, email: user.email, password: 'secret'
    post topics_path, topic: { name: 'Sticky Topic?', sticky: "1" }
    topic = Topic.last
    topic.name.should eq("Sticky Topic?")
    topic.should_not be_sticky
  end
end