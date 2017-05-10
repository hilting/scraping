
pyenv local 3.5.2
scrapy crawl hbrjp > ~/wired/HelloScrapy/spiders/MIT/hbrjp_auto/hbrjp_scraped.txt
#cat hbrjp_scraped.txt| tr -d "ハーバード"|tr -d "ビジネス" > hbrjp_scraped.txt
mecab ~/wired/HelloScrapy/spiders/MIT/hbrjp_auto/hbrjp_scraped.txt|grep "名詞"|cut -f 1|sort|uniq -c|sort -n -r|tr -d \" > ~/wired/HelloScrapy/spiders/MIT/hbrjp_auto/hbrjp_mecabed.txt
#mecab aaaaa.txt|grep "名詞"|cut -f 1|sort|uniq -c|sort -n -r|tr -d \" > mitjp_mecabed.txt
cat ~/wired/HelloScrapy/spiders/MIT/hbrjp_auto/hbrjp_mecabed.txt | awk '{printf "%-1s,%s\n",$1,$2}' > ~/wired/HelloScrapy/spiders/MIT/hbrjp_auto/hbrjp_mecabed.csv
pyenv local 2.7.8
#gcloud auth login
gsutil cp ~/wired/HelloScrapy/spiders/MIT/hbrjp_auto/hbrjp_mecabed.csv gs://webmining-playground.appspot.com/
bq rm -f mit.hbrjp_bq2
bq rm -f mit.hbrjp_bq
bq load --max_bad_records=1000 mit.hbrjp_bq gs://webmining-playground.appspot.com/hbrjp_mecabed.csv count:integer,name:string

