require 'spec_helper'

describe User do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it {
    should validate_format_of(:email)
      .to_allow("user@example.com")
      .not_to_allow("invalid_email_without_at")
  }
  context 'autentication' do
    let(:user) { FactoryGirl.build_stubbed(:user, password: "valid_password") }
    it "should authenticate with valid password" do
      expect(user.authenticate("valid_password")).to be true
    end
    it "should not authenticate with invalid password" do
      expect(user.authenticate("invalid_password")).to be false
    end
  end
end
