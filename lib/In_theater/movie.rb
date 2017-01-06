class In_theater::Movie
  attr_accessor :name, :url, :summary

  def initialize(name = nil, url = nil)
    @name = name
    @url = url
  end

  def self.all
    @@all ||= scrape_now_playing
  end

  def self.movies
    @@movies ||= self.all.collect { |d| custom_method(d.url)}
  end

  def self.find(id,array)
    array[id-1]
  end

  def self.find_by_name(name, array)

    arr ||= array.collect.with_index(1) do |m, i|
      m, i = m, i if ( m.name.downcase.strip == name.downcase.strip ||
      m.name.split("(").first.strip.downcase == name.downcase.strip)
    end

    arr.detect {|n| n if n != nil}

  end

  def self.summary(obj)

    doc ||= Nokogiri::HTML(open(obj.url.gsub("movieoverview", "plotsummary")))

    if doc.search("p[class='subpage-descriptive-content']").text == ""
      doc = Nokogiri::HTML(open(obj.url))
      puts "-------------- #{obj.name} summary --------------"
      puts doc.search("span[id='SynopsisTextLabel']").text

    else
      puts "-------------- #{obj.name} summary --------------"
      puts doc.search("p[class='subpage-descriptive-content']").text

    end

  end

  private
    def self.scrape_now_playing
      puts "Enter zip code:"
      input = gets.strip

      doc = Nokogiri::HTML(open("http://www.fandango.com/#{input.to_i}_movietimes/"))

      names = doc.search("a[class='light showtimes-theater-title']")


      names.to_a.collect { |name| new(name.children.text.strip, name.attributes.to_a[1][1].value) }

    end




    def self.custom_method(arg)
      doc ||= Nokogiri::HTML(open(arg))
      doc.search("a[class='dark showtimes-movie-title']").to_a.collect.with_index(1) do |name, i|
          new(name.children.text.strip, name.attributes.to_a[1][1].value )
      end

    end

    def doc
      @doc ||= Nokogiri::HTML(open(self.url))
    end

end
