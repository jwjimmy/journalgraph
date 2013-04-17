

class ArticlesController < ApplicationController
  # GET /articles
  # GET /articles.json
  def index    

  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article = Article.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end

  def search
    # puts params['query']
    tag = params['query']
    # search_type = params[]

    @articles = Article.find(:all, conditions: ['summary LIKE ?', "%#{tag}%"])
    
    # puts 'ARTICLES ###############################'
    # puts @articles
    @found = 1
    if @articles.nil?
      @msg = "None found, try again..."
      @found = 0
    end

    render "results"
  end

end

