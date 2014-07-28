class ApiBase < Grape::API
  default_format :hal
  parser :hal, Grape::Parser::Json
  error_formatter :hal, Grape::ErrorFormatter::Json

  rescue_from Mongoid::Errors::DocumentNotFound do |e|
    rack_response({
      message: "Document not found"
    }.to_json, 404)
  end

  rescue_from :all

  class Formatter
    def call(object, env)
      if object == :top_level
        YaksCfg.yaks.serialize(object, env: env, mapper: RootMapper)
      elsif object.class == String
        { message: object }.to_json
      else
        YaksCfg.yaks.serialize(object, env: env)
      end
    end
  end

  Yaks::Format.mime_types.each do |name, mime_type|
    content_type name, mime_type
    formatter name, Formatter.new
  end

  get do
    :top_level
  end

  helpers ApiHelpers
  mount ApiUsers
end
