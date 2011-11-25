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

      @page = @page.split("\n").map{|res| dat_parse(res).flatten}.delete_if{|res| res == []}
      @page.map{|res| 
        res[6] = res[6].gsub("<>","").gsub("<br>","\n")
        unless res[5] == nil 
          res[5] = res[5].scan(/.*&gt;&gt;(\d+).*/).flatten[0]
          res[5] = ">>" + res[5] + res[6]
        else
          res[5] = res[6]
        end
        res.pop

      }
      @thre = @page.map{|res|
        {name: res[0],place: res[1], date: res[2], id: res[3], point: res[4],text: res[5]}
      }
    end

    def to_a
      @array = @page.split("\n")
    end

    def dat_parse(res)
      res_array = res.scan(/(^\S+)\<\/b\>(\(.*\))\<b\>\<\>\S*\<\>(.+)\sID:(\S+)\s*(BE.*)*\<\>\s(\<a.*\<\/a\>)*(.*)/)
    end



    attr_accessor :dat_url,:page,:thre
  end

end



