export SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt

nohup /usr/local/bin/feedstail -i 9000  -f {title}__{author}__{link} -r -u 'https://pubmed.ncbi.nlm.nih.gov/rss/search/1zOrwYPa_1R36je7bXDCn-ulFb8iCO8V-epzbaRU1f9qjKT9Pu/?limit=15'  | perl /home/pcarlton/code/pubmed-rss-twitter/rss-filter2.pl >> /home/pcarlton/meiotwitter.fifo

nohup /usr/local/bin/feedstail -i 3600 -e -r -u "http://connect.biorxiv.org/biorxiv_xml.php?subject=all" -f {title}__{author}__{link}__{summary} | perl /home/pcarlton/code/pubmed-rss-twitter/biorxiv-filter.pl >> /home/pcarlton/meiotwitter.fifo
