# Doing it all in the controller cause the app seems simple
# No point bloating out with libraries or splitting logic
# ¯\_(ツ)_/¯
class NewsController < ApplicationController
  def results
    render json: SearchClient.search(
      index: 'news',
      body: {
        query: {
          bool: {
            must: {
              term: { text: params[:query] }
            },
            must: {
              range: {
                timestamp: {
                  gte: params[:after].to_i, # example was in seconds. description in milliseconds ¯\_(ツ)_/¯
                  lt: params[:before].to_i
                }
              }
            }
          }
        },
        size: 0,
        aggs: {
          first_agg: {
            date_histogram: {
              field: 'timestamp',
              calendar_interval: params[:interval]
            },
            aggs: {
              second_agg: {
                terms: {
                  field: 'medium'
                }
              }
            }
          }
        }
      }
    )
  end
end
