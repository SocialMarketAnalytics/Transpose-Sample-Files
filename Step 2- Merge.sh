cd StockTwits\ Data/date/
for dir in */; do { find ${dir} -name "*.txt" | head -n 1 | xargs -n 1 head -n 1; find ${dir} -name "*.txt" | xargs -n 1 tail -n +2; } > ${dir:0:10}.txt; done