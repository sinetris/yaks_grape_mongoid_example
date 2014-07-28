require 'spec_helper'

describe "ApiBase#users" do
  def app
    ApiBase
  end

  let(:headers) { {
    "CONTENT_TYPE" => "application/hal+json"
  } }

  describe "GET /users/{id}" do
    let(:user) { FactoryGirl.build_stubbed(:user) }

    it "return a user given an id" do
      expect(User).to receive(:find) { user }
      get "/users/#{user.id}", {}, headers
      expect(last_response.body).to include user.email
      expect(last_response.status).to be 200
    end

    it "return 404 given an invalid id" do
      get "/users/invalid-id", {}, headers
      expect(last_response.status).to be 404
    end
  end

  describe "GET /users" do
    let!(:limit_size) { CollectionMapper::LIMIT_SIZE }
    let!(:num_of_users) { limit_size + 1 }
    let(:users) { FactoryGirl.build_list(:user, num_of_users) }

    before { expect(User).to receive(:all) { users } }

    it "return a collection" do
      get "/users", {}, headers
      expect(last_response.status).to be 200
      collection = JSON.parse(last_response.body)
      expect(collection['count']).to be num_of_users
      expect(collection['offset']).to be 0
      expect(collection['limit']).to be limit_size
      expect(collection['_embedded']['collection'].count).to be limit_size
    end

    it "return a collection limited by limit" do
      get "/users?limit=5", {}, headers
      expect(last_response.status).to be 200
      collection = JSON.parse(last_response.body)
      expect(collection['count']).to be num_of_users
      expect(collection['_embedded']['collection'].count).to be 5
    end
  end

  describe "POST /users" do
    let(:user) { FactoryGirl.attributes_for(:user) }

    it "create a user given valid params" do
      post "/users", user.to_json, headers
      expect(last_response.body).to include user[:email]
      expect(last_response.status).to be 201
    end
  end

  describe "DELETE /users/{id}" do
    let(:user) { FactoryGirl.build_stubbed(:user) }
    before { expect(User).to receive(:find) { user } }

    it "create a user given valid params" do
      expect(user).to receive(:destroy)
      delete "/users/#{user.id}", {}, headers
      expect(last_response.body).to include user[:email]
      expect(last_response.status).to be 200
    end
  end

  describe "PATCH /users/{id}" do
    let!(:user) { FactoryGirl.build_stubbed(:user) }
    let!(:new_name) { "new name" }
    let(:new_user) {nu = user; nu.name = new_name; nu}
    before do
      expect(User).to receive(:find) { user }
      expect(user).to receive(:update_attributes!).with({name: new_name}) {new_user}
    end

    it "create a user given valid params" do
      patch "/users/#{user.id}", {name: new_name}.to_json, headers
      expect(last_response.body).to include new_name
      expect(last_response.status).to be 200
    end
  end
end
