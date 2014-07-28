class ApiUsers < Grape::API
  resource :users do
    desc 'Retrieves users list'
    get do
      User.all
    end

    desc "Retrieves a user by id."
    get '/:id' do
      User.find(params[:id])
    end

    desc "Create a new user."
    params do
      requires :name,     type: String, desc: "Name"
      requires :email,    type: String, desc: "Email"
      requires :password, type: String, desc: "Password"
    end
    post '/' do
      @user = User.new(declared_params)
      if @user.save
        @user
      else
        error!({message: @user.errors}, 422)
      end
    end

    desc "Update a user by id."
    params do
      optional :name,     type: String, desc: "Name"
      optional :email,    type: String, desc: "Email"
      optional :password, type: String, desc: "Password"
    end
    patch "/:id" do
      @user = User.find(params[:id])
      if @user.update_attributes!(declared_params)
        @user
      else
        error!({message: @user.errors}, 422)
      end
    end

    desc "Delete a user by id."
    delete "/:id" do
      @user = User.find(params[:id])
      @user.destroy
      @user
    end
  end
end
