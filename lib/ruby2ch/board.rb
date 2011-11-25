require 'mechanize'
require 'ruby2ch/thre'
require 'thread'
require 'ruby2ch/datparse'
include Ruby2ch

module Ruby2ch
  class Board
    def initialize(url)
      @agent = Mechanize.new
      url = url + "subback.html"
      @page = @agent.get(url)
      @links = @page.links.map{|link| [link.href,link.text]}#.map{|link| link.split("/")[0]}

      @links.map!{|link,title|  [link.split("/")[0],title]}

      @links.map!{|link,title| 
        puts link
        [url.sub("/news/subback.html","/test/read.cgi/news/") + link,title]}
      
      @links.select!{|link,title| /\/\d*$/ =~link}
    end
    
    def threads(num)
      threads = []
      thread_num = 100
      num.times{|i|
        threads << Thread.start(i){|i| Dat.new(@links[i][0],@links[i][1])}
      }

      threads.map!{|thre|
        thre.join.value
      }

      return threads

    end
  
    attr_accessor :links
  end

end
