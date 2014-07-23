require 'forwardable'

class App
  class << self
    extend Forwardable
    def_delegators :app, :map, :use, :call
    alias :_new :new
    def new(*args, &block)
      app.run _new(*args, &block)
      app
    end
    def app
      @app ||= Rack::Builder.new
    end
  end

  map "/" do
    run lambda { |env|
      [200, {'Content-Type' => 'text/plain'}, ["Welcome!"]]
    }
  end
end
