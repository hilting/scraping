
pyenv local 3.5.2
scrapy crawl hbr > ~/wired/HelloScrapy/spiders/MIT/hbr_auto/hbr_scraped.txt
mecab ~/wired/HelloScrapy/spiders/MIT/hbr_auto/hbr_scraped.txt|grep "固有名詞"|cut -f 1|sort|uniq -c|sort -n -r|tr -d \" > ~/wired/HelloScrapy/spiders/MIT/hbr_auto/hbr_mecabed.txt
#mecab aaaaa.txt|grep "名詞"|cut -f 1|sort|uniq -c|sort -n -r|tr -d \" > hbr_mecabed.txt
cat ~/wired/HelloScrapy/spiders/MIT/hbr_auto/hbr_mecabed.txt | awk '{printf "%-1s,%s\n",$1,$2}' > ~/wired/HelloScrapy/spiders/MIT/hbr_auto/hbr_mecabed.csv
pyenv local 2.7.8
#gcloud auth login
gsutil cp ~/wired/HelloScrapy/spiders/MIT/hbr_auto/hbr_mecabed.csv gs://webmining-playground.appspot.com/
bq rm -f mit.hbr_bq
bq load --max_bad_records=1000 mit.hbr_bq gs://webmining-playground.appspot.com/hbr_mecabed.csv count:integer,name:string

