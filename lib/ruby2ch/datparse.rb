#encoding: utf-8
require 'mechanize'
require 'kconv'
module Ruby2ch
  class Dat
    def initialize(url)
      #http://uni.2ch.net/test/read.cgi/news/1322032301/l50
      #http://bg20.2ch.net/test/r.so/uni.2ch.net/news/1322032301/
      url_elements = url.split("/")
      @dat_url = "http://bg20.2ch.net/test/r.so/" + url_elements[2] + "/" + url_elements[5] + "/" + url_elements[6] + "/"
      @agent = Mechanize.new
      @page = @agent.get(@dat_url).body.toutf8
      
    end

    def to_a
      @array = @page.split("<br>")
    end

        attr_accessor :dat_url,:page
  end

end



d = Ruby2ch::Dat.new("http://uni.2ch.net/test/read.cgi/news/1322032301/")
p d.page

#parse
#(^\S+)\<\/b\>(\(.+\))\<b\>\<\>\S+\<\>(.+)\sID:(\S+)<>(.*)
