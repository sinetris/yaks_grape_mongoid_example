class CollectionMapper < Yaks::CollectionMapper
  attributes :count, :offset, :limit

  link :previous, :previous_link
  link :next, :next_link

  LIMIT_SIZE = 20

  def request
    Rack::Request.new(env)
  end

  def params
    request.params
  end

  def offset
    params.fetch('offset') { 0 }.to_i
  end

  def limit
    params.fetch('limit') { LIMIT_SIZE }.to_i
  end

  alias full_collection collection

  def collection
    collection = full_collection

    if mapper_stack.any? || collection.count < limit
      collection
    elsif %w[offset limit].all? &collection.method(:respond_to?)
      collection.offset(offset).limit(limit)
    else
      collection.drop(offset).take(limit)
    end
  end

  def count
    full_collection.count
  end

  def previous_link
    if offset > 0
      URITemplate.new("#{env['PATH_INFO']}{?offset,limit}").expand(offset: [offset - limit, 0].max, limit: limit)
    end
  end

  def next_link
    if offset + limit < count
      URITemplate.new("#{env['PATH_INFO']}{?offset,limit}").expand(offset: offset + limit, limit: limit)
    end
  end
end
