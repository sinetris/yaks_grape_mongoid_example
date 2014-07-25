module YaksCfg
  def self.yaks
    @yaks ||= Yaks.new do
      rel_template 'rels:{dest}'

      after do |result|
        JSON.pretty_generate result
      end

      map_to_primitive BSON::ObjectId do |id|
        id.to_s
      end

      map_to_primitive Date, Time, DateTime do |date|
        date.iso8601
      end
    end
  end
end
