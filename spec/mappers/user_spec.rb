require 'spec_helper'

describe UserMapper do
  let(:user) { FactoryGirl.build_stubbed(:user) }
  let(:mapped_user) { YaksCfg.yaks.serialize(user) }
  it "contain the user name" do
    expect(mapped_user).to include user.name
  end
  it "contain an href" do
    expect(mapped_user).to include "users/#{user.id}"
  end
end
