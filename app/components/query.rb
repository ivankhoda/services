module Query
  class OrderSorter
    OrderConfig = Struct.new(:query)
    def initialize(query)
      @query = query
      @permitted_keys = %w[client assignee category]
    end

    def parsed_query
      Rack::Utils.parse_nested_query(@query)
    end

    def query_keys_valid?
      parsed_query.keys.any? { |i| @permitted_keys.include? i }
    end

    def request
      parsed_query
    end

    private

    attr_reader :query, :permitted_keys

    def query_error(query)
      raise StandardError, "#{query} has an invalid params"
    end
  end
end
