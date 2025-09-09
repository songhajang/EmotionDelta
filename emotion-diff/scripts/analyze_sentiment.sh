#!/usr/bin/env bash
set -euo pipefail

DIARY_DIR="diaries"
POS_LX="lexicon/positive_ko.txt"
NEG_LX="lexicon/negative_ko.txt"
OUT_DIR="output/reports"
CSV="${OUT_DIR}/sentiment_daily.csv"
LATEST="${OUT_DIR}/summary_latest.txt"

mkdir -p "$OUT_DIR"

# 헤더
echo "date,pos,neg,net,tokens,d_pos,d_neg,d_net" > "$CSV"

# 이전값 보관 변수
prev_pos=""
prev_neg=""
prev_net=""

# 일자 순회
for f in $(ls -1 "${DIARY_DIR}"/20*.txt 2>/dev/null | LC_ALL=C sort); do
  date=$(basename "$f" .txt)

  # 토큰화: 한글/영문/숫자만 추출하여 줄단위 토큰
  TOKENS_FILE="$(mktemp)"
  tr -sc '[:alnum:][:alpha:][:digit:][가-힣]' '\n' < "$f" | sed '/^$/d' > "$TOKENS_FILE"

  # 사전 교집합 개수 (정확 일치)
  # grep -Fxf: -F(고정문자열) -x(행 전체 일치) -f(패턴파일) -o(매치만 출력) → 라인수 = 개수
  # pos=$(grep -Fxo -f "$POS_LX" "$TOKENS_FILE" 2>/dev/null | wc -l | tr -d ' ')
  # neg=$(grep -Fxo -f "$NEG_LX" "$TOKENS_FILE" 2>/dev/null | wc -l | tr -d ' ')
 pos=$( (grep -Fxo -f "$POS_LX" "$TOKENS_FILE" 2>/dev/null || true) | wc -l | tr -d ' ')
 neg=$( (grep -Fxo -f "$NEG_LX" "$TOKENS_FILE" 2>/dev/null || true) | wc -l | tr -d ' ')

  tokens=$(wc -l < "$TOKENS_FILE" | tr -d ' ')

  net=$(( pos - neg ))

  # 전일 대비 델타
  if [ -z "${prev_pos}" ]; then
    d_pos=""
    d_neg=""
    d_net=""
  else
    d_pos=$(( pos - prev_pos ))
    d_neg=$(( neg - prev_neg ))
    d_net=$(( net - prev_net ))
  fi

  echo "${date},${pos},${neg},${net},${tokens},${d_pos},${d_neg},${d_net}" >> "$CSV"

  # 이전값 업데이트
  prev_pos=$pos
  prev_neg=$neg
  prev_net=$net

  rm -f "$TOKENS_FILE"
done

# 최신 요약
last_line=$(tail -n 1 "$CSV")
IFS=',' read -r d p n net t dp dn dnet <<< "$last_line"
{
  echo "Date: $d"
  echo "Positive: $p, Negative: $n, Net: $net"
  echo "Δ vs prev — Δpos: ${dp:-0}, Δneg: ${dn:-0}, Δnet: ${dnet:-0}"
} > "$LATEST"

echo "[OK] Sentiment CSV: $CSV"
echo "[OK] Latest summary: $LATEST"
