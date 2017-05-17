# -*- coding: utf-8 -*-
import re
from scrapy.contrib.spiders import CrawlSpider, Rule
from scrapy.contrib.linkextractors import LinkExtractor
from scrapy.selector import Selector
from HelloScrapy.items import PageInfoItem

class HelloSpider(CrawlSpider):
    # scrapyをCLIから実行するときの識別子
    name = "hbrjp"
    # spiderに探査を許可するドメイン
    allowed_domains = ["www.dhbr.net"]
    # 起点(探査を開始する)URL
    start_urls = ["http://www.dhbr.net/"]
    # LinkExtractorの引数で特定のルール(例えばURLにnewを含むページのみスクレイプするなど)を指定可能だが、今回は全てのページを対象とするため引数はなし
    # Ruleにマッチしたページをダウンロードすると、callbackに指定した関数が呼ばれる
    # followをTrueにすると、再帰的に探査を行う
    list_allow = [r'(.*articles/-/4...)']
    rules = [Rule(LinkExtractor(allow=list_allow), callback='parse_pageinfo', follow=True)]


    def parse_pageinfo(self, response):
        sel = Selector(response)
        item = PageInfoItem()
        item['URL'] = response.url
        # ページのどの部分をスクレイプするかを指定
        # xPath形式での指定に加え、CSS形式での指定も可能
#        item['text'] = sel.xpath('/html/head/title/text()').extract_first()
        
        for i in sel.xpath('//p//text()').extract():
            if i.find("\n") ==  -1:
                print(i)
        #if sel.xpath('//*/text()').extract_first().find("\n\n") == -1:
        print (item)
        print("")
