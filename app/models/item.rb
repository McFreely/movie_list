class Item < ActiveRecord::Base

  belongs_to :user
  before_save :rottenize

  validates :title, :presence => true, :length => { :maximum => 75}

  scope :completed, where(:completed => true)
  scope :incomplete, where(:completed => false)

  default_scope :order => 'items.updated_at DESC'

  protected
    def rottenize  # named after Rotten Tomatoes
      # Request movie search list from RT API and use to complete item attributes
        title = self.title #get user query
        unit = "min"
        options = {:query => {:apikey => :rnbrbgqv7teq8fvkz2ppk857,
                              :q => title,
                              :page_limit => 1,
                              :page => 1} }

        response = HTTParty.get("http://api.rottentomatoes.com/api/public/v1.0/movies.json", options)
        arr = JSON.parse(response.body)['movies']  #the movie array from the response from RT API
        movie = Hash[*arr]    # Convert arr into hash

        # update Item attributes
        self.title = movie['title']
        self.year = movie['year']
        runtime = movie['runtime']
        self.runtime = "#{runtime} #{unit}"
        self.synopsys = movie['synopsis']
          if synopsys.empty?
            self.synopsys = "There is no resume for the moment, try the RT link below"
          end

        self.ratings = movie['ratings']['critics_score']
        self.poster = movie['posters']['profile']
        self.link = movie['links']['alternate']
    end
end
