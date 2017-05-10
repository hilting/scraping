pyenv local 3.5.2 
scrapy crawl mitjp > mitjp_scraped.txt
mecab mitjp_scraped.txt|grep "固有名詞"|cut -f 1|sort|uniq -c|sort -n -r|tr -d \" > mitjp_mecabed_koyuumeishi.txt
cat mitjp_mecabed_koyuumeishi.txt | awk '{printf "%-1s,%s\n",$1,$2}' > mitjp_mecabed_koyuumeishi.csv
pyenv local 2.7.8
#gcloud auth login
gsutil cp mitjp_mecabed_koyuumeishi.csv gs://webmining-playground.appspot.com/
bq rm -f mit.mitjp_bq_koyuu
bq load --max_bad_records=1000 mit.mitjp_bq_koyuu gs://webmining-playground.appspot.com/mitjp_mecabed_koyuumeishi.csv count:integer,name:string





