class SearchController < ApplicationController

  def search_keyword
    results = FaradayClient.search_results_by_type(query: params[:query], type: params[:type], count: params[:count])
    render json: { message: "Search Result for type=#{params[:type]}", results: results, timestamp: DateTime.current.in_time_zone('UTC').in_time_zone('UTC') }, status: :ok
  rescue StandardError => e
    render json: { message: "Error Searching Result=#{e.message}", timestamp: DateTime.current.in_time_zone('UTC').in_time_zone('UTC')}
  end
end
