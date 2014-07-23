require "spec_helper"

RSpec.describe "App" do
  def app
    App
  end

  describe "GET /" do
    it "should show a Welcome message." do
      get "/", {}, {}
      expect(last_response).to be_ok
      expect(last_response.body).to include "Welcome!"
    end
  end

  context 'using capybara', type: :feature do
    describe "GET /" do
      it "should show a Welcome message" do
        visit "/"
        expect(page.body).to include "Welcome!"
      end
    end
  end
end
