class FaradayClient
  require 'json'
  LANGUAGE = "en".freeze
  DEAFULT_SEARCH_TERM = "APM".freeze
  DEAFULT_PAGE_COUNT = 10
  DEAFULT_OFFSET = 1
  DEAFULT_TYPE = "pdf".freeze

  def self.get_connection(base_url)
    Faraday.new(base_url, headers: { 'Accept': 'application/json' })
  end

  def self.search_results(query:, count:, offset:, property:)
    conn = get_connection(URLS[:splunk_search_url])
    response = conn.get(nil, nil) do |req|
      req.url "/1.0/rest/search/"
      req.params[:language] = LANGUAGE
      req.params[:query] = query.present? ? query : DEAFULT_SEARCH_TERM
      req.params[:count] = get_count(count)
      req.params[:offset] = offset.present? ? offset : DEAFULT_TYPE
      req.params[:property] = property
    end
    JSON.parse(response.body, symbolize_names: true) if response.status == 200
  rescue Faraday::ConnectionFailed => e
    Rails.logger.error e.message
  end

  def self.search_results_by_type(type:, query:, count:)
    total_results = []
    # writing this logic since there is no clarity or document provided for the splunk API if it support elastic way of search
    # on type query
    # it might support filter by type or link property contains .pdf
    # There is little bit of performance hit
    offset = 1
    result_count = get_count(count)
    if valid_type(type)
      while total_results.size < result_count
        results = search_results(query: query, count: result_count, offset: offset, property: "main")
        return total_results unless results.present?

        results[:message][:results][:main].each do |result|
          total_results.append(result) if result[:link].downcase.include? type
          break if total_results.size == result_count
        end
        offset = result_count + offset
      end
    end
    total_results
  end

  def self.get_count(count)
    count.present? ? count.to_i : DEAFULT_PAGE_COUNT
  end

  def self.valid_type(type)
    type.present? && (%w[pdf html].include? type.downcase)
  end
end