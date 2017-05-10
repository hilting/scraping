pyenv local 3.5.2 
scrapy crawl mitjp > ~/wired/HelloScrapy/spiders/MIT/mitjp_auto/mitjp_scraped.txt
mecab ~/wired/HelloScrapy/spiders/MIT/mitjp_auto/mitjp_scraped.txt|grep "名詞"|cut -f 1|sort|uniq -c|sort -n -r|tr -d \" > ~/wired/HelloScrapy/spiders/MIT/mitjp_auto/mitjp_mecabed.txt
cat ~/wired/HelloScrapy/spiders/MIT/mitjp_auto/mitjp_mecabed.txt | awk '{printf "%-1s,%s\n",$1,$2}' > ~/wired/HelloScrapy/spiders/MIT/mitjp_auto/mitjp_mecabed.csv
pyenv local 2.7.8
#gcloud auth login
gsutil cp ~/wired/HelloScrapy/spiders/MIT/mitjp_auto/mitjp_mecabed.csv gs://webmining-playground.appspot.com/
bq rm -f mit.mitjp_bq
bq load --max_bad_records=1000 mit.mitjp_bq gs://webmining-playground.appspot.com/mitjp_mecabed.csv count:integer,name:string





