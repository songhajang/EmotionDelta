#!/usr/bin/env bash
set -euo pipefail

CSV="output/reports/sentiment_daily.csv"
PNG="output/charts/sentiment_trend.png"
mkdir -p output/charts

if [ ! -s "$CSV" ]; then
  echo "[ERR] CSV not found or empty: $CSV"
  exit 1
fi

# gnuplot 스크립트를 히어독으로 생성 후 실행
gnuplot <<'GP'
set datafile separator comma
set terminal pngcairo size 1200,500 enhanced font "Arial,11"
set output "output/charts/sentiment_trend.png"
set title "Emotion Diary Trend"
set xlabel "Date"
set ylabel "Count"
set grid ytics
set key outside right

# X축은 문자열(날짜)로 사용
set xdata time
set timefmt "%Y-%m-%d"
set format x "%Y-%m-%d"
set xtics rotate by -30

# 1:date, 2:pos, 3:neg, 4:net
plot \
  "output/reports/sentiment_daily.csv" using 1:2 with lines lw 2 title "Positive", \
  "" using 1:3 with lines lw 2 title "Negative", \
  "" using 1:4 with lines lw 2 title "Net(+)"

unset output
GP

echo "[OK] Chart saved: $PNG"
