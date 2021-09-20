class NewsController < ApplicationController
  def results
    render json: SearchClient.search(
      index: 'news',
      body: {
        query: {
          match: {
            title: {
              query: 'scott morrison'
            }
          }
        }
      }
    )
  end
end
