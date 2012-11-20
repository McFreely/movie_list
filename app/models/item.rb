class Item < ActiveRecord::Base
    
  belongs_to :user
  before_save :rottenize
  
  validates :title, :presence => true, :length => { :maximum => 75}
  validates :categorie, :presence => true
  
  scope :completed, where(:completed => true)
  scope :incomplete, where(:completed => false)
  
  default_scope :order => 'items.updated_at DESC'
  
  protected
    def rottenize  # named after Rotten Tomatoes
      # Request movie search list from RT API and use to complete item attributes
      if self.categorie === "movie" 
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
            self.synopsys = "There no resume for the moment, try the RT link below"
          end
          
        self.ratings = movie['ratings']['critics_score']
        self.poster = movie['posters']['profile']
        self.link = movie['links']['alternate']
      end
       
      if self.categorie === "book" 
        title = self.title #get user query
        unit = "pages"
        options = {:query => {:apikey => :AIzaSyBhxlW8JGu0raeW15CEFbITKpsczlTrscA, 
                              :q => title,
                              :maxResults => 1,
                              :orderBy => :relevance
                              } }
        
        response = HTTParty.get("https://www.googleapis.com/books/v1/volumes", options)
        arr = JSON.parse(response.body)['items'] # Book array from Google book api response
        book = Hash[*arr] #convert array into hash
        
        # Update item atributes
        self.title = book["volumeInfo"]["title"]
        self.year = book["volumeInfo"]["publishedDate"]
        page_count = book["volumeInfo"]["pageCount"]
          if page_count.nil?
              self.runtime == ""
          else
              self.runtime = "#{page_count} #{unit}"
          end
        self.synopsys = "There no resume for the moment, try the Google link below"
        self.poster = book['volumeInfo']['imageLinks']['thumbnail']
        self.link = book['volumeInfo']["infoLink"]
      end
      
      if self.categorie === "game"
        title = self.title #get user query
        #unit = ??? (if necessary)
        options = {:query => {:api_key => :d0a9d2ee34c84a894200553113b474af417d6a9e,
                              :limit => 1,
                              :query => title,
                              :ressources => "game",
                              :format => "json",
                              :field_list => "deck,image,name,original_release_date,site_detail_url",
                              }}
                              
        response = HTTParty.get("http://api.giantbomb.com/search/", options)
        arr = JSON.parse(response.body)["results"]
        game = Hash[*arr]
        
        if game['name'] === nil
          self.title = self.title
        else
          self.title = game['name']
        end
        
        if game['original_release_date'] != nil
          self.year = game['original_release_date'][0..10]
        end
        self.synopsys = game['deck']
        if game["image"] != nil
          self.poster = game['image']['thumb_url']
        end
        self.link = game['site_detail_url']
      end
        
    end

end
