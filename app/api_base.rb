class ApiBase < Grape::API
  default_format :hal

  class Formatter
    def call(object, env)
      if object == :top_level
        YaksCfg.yaks.serialize(object, env: env, mapper: RootMapper)
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
end
