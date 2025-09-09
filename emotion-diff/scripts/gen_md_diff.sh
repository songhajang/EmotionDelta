#!/usr/bin/env bash
set -euo pipefail

CSV="output/reports/sentiment_daily.csv"
OUT="output/reports/daily_diff.md"
CHART="output/charts/sentiment_trend.png"   # (사용 안해도 유지)

[ -s "$CSV" ] || { echo "[ERR] CSV not found: $CSV"; exit 1; }
mkdir -p "$(dirname "$OUT")"

# 최근 2행
last2=$(tail -n 2 "$CSV")
if [ "$(echo "$last2" | wc -l)" -lt 2 ]; then
  echo "[ERR] Not enough rows in $CSV (need >=2)"
  exit 1
fi

prev=$(echo "$last2" | head -n1)
curr=$(echo "$last2" | tail -n1)

IFS=',' read -r d1 pos1 neg1 net1 tok1 dp1 dn1 dnet1 <<< "$prev"
IFS=',' read -r d2 pos2 neg2 net2 tok2 dp2 dn2 dnet2 <<< "$curr"

# 정수화(빈값 대비)
pos1=${pos1:-0}; neg1=${neg1:-0}; net1=${net1:-0}
pos2=${pos2:-0}; neg2=${neg2:-0}; net2=${net2:-0}

# 변화량 (표에 그대로 사용)
dpos=$(( pos2 - pos1 ))
dneg=$(( neg2 - neg1 ))
dnet=$(( net2 - net1 ))

fmt_delta () {
  local v="${1:-0}"
  if [ "$v" -gt 0 ]; then echo "+$v"; elif [ "$v" -lt 0 ]; then echo "$v"; else echo "0"; fi
}
delta_pos=$(fmt_delta "$dpos")
delta_neg=$(fmt_delta "$dneg")
delta_net=$(fmt_delta "$dnet")

# ▼ 여기서부터: 실제 diff 명령어 사용을 위한 점수 스냅샷 생성
TMP1="$(mktemp)"; TMP2="$(mktemp)"
{
  echo "긍정(+): ${pos1}"
  echo "부정(-): ${neg1}"
  echo "순(긍-부): ${net1}"
} > "$TMP1"

{
  echo "긍정(+): ${pos2}"
  echo "부정(-): ${neg2}"
  echo "순(긍-부): ${net2}"
} > "$TMP2"

# 마크다운 출력 (기존 레이아웃 유지, diff 블록만 실제 diff 결과로 대체)
{
  echo "## 당신의 감정 변화"
  echo
  echo
  echo "| 지표       | 전일(${d1}) | 금일(${d2}) | 증감 |"
  echo "|------------|------------:|------------:|:----:|"
  echo "| 긍정(+)    | ${pos1}     | ${pos2}     | ${delta_pos} |"
  echo "| 부정(-)    | ${neg1}     | ${neg2}     | ${delta_neg} |"
  echo "| 전날과 비교  | ${net1}     | ${net2}     | ${delta_net} |"
  echo
  echo "```diff"
  diff -u --label "${d1} 점수" "$TMP1" --label "${d2} 점수" "$TMP2" || true
  echo "```"
} > "$OUT"

rm -f "$TMP1" "$TMP2"

echo "[OK] Markdown diff report: $OUT"
