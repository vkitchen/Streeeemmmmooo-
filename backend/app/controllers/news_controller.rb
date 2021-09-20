# Doing it all in the controller cause the app seems simple
# No point bloating out with libraries or splitting logic
# ¯\_(ツ)_/¯
class NewsController < ApplicationController
  def results
    render json: SearchClient.search(
      index: 'news',
      body: {
        query: {
          match: {
            title: {
              query: params[:query]
            }
          }
        }
      }
    )
  end
end
