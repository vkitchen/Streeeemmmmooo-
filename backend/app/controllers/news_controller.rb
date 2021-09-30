# Doing it all in the controller cause the app seems simple
# No point bloating out with libraries or splitting logic
# ¯\_(ツ)_/¯
class NewsController < ApplicationController
  def results
    render json: SearchClient.search(
      index: 'news',
      body: {
        query: {
          # match: {
          #   title: {
          #     query: params[:query]
          #   }
          # },
          range: {
            timestamp: {
              gte: params[:after].to_i * 1000,
              lt: params[:before].to_i * 1000
            }
          }
        },
        aggs: {
          first_agg: {
            date_histogram: {
              field: 'timestamp',
              calendar_interval: '1d'
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
