require 'mechanize'
require 'ruby2ch/thre'
require 'thread'
require 'ruby2ch/datparse'
include Ruby2ch

module Ruby2ch
  class Board
    def initialize(url)
      @agent = Mechanize.new
      @page = @agent.get(url)
      @links = @page.links.map{|link| link.href}.map{|link| link.split("/")[0]}
      @links.map!{|link| url.sub("/news/subback.html","/test/read.cgi/news/") + link}
      @links.select!{|x| /\/\d*$/ =~x}
    end
    
    def threads
      threads = []
      @links.each{|link|
        threads << Thread.start(link){|link| Dat.new(link)}
      }

      threads.map!{|thre|
        thre.join.value
      }

      return threads

    end
  
    attr_accessor :links
  end

end
