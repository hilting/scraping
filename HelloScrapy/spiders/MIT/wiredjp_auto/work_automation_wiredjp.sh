
pyenv local 3.5.2 
scrapy crawl wiredjp > ~/wired/HelloScrapy/spiders/MIT/wiredjp_auto/wiredjp_scraped.txt
mecab ~/wired/HelloScrapy/spiders/MIT/wiredjp_auto/wiredjp_scraped.txt|tr -d \'|tr -d \"|grep "名詞"|cut -f 1|sort|uniq -c|sort -n -r > ~/wired/HelloScrapy/spiders/MIT/wiredjp_auto/wiredjp_mecabed.txt
#mecab aaaaa.txt|grep "名詞"|cut -f 1|sort|uniq -c|sort -n -r|tr -d \" > mitjp_mecabed.txt
cat ~/wired/HelloScrapy/spiders/MIT/wiredjp_auto/wiredjp_mecabed.txt | awk '{printf "%-1s,%s\n",$1,$2}' > ~/wired/HelloScrapy/spiders/MIT/wiredjp_auto/wiredjp_mecabed.csv
pyenv local 2.7.8
#gcloud auth login
gsutil cp ~/wired/HelloScrapy/spiders/MIT/wiredjp_auto/wiredjp_mecabed.csv gs://webmining-playground.appspot.com/
bq rm -f mit.wiredjp_bq2
bq load --max_bad_records=100000 mit.wiredjp_bq2 gs://webmining-playground.appspot.com/wiredjp_mecabed.csv count:integer,name:string



