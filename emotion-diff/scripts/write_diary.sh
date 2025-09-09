#!/usr/bin/env bash
set -euo pipefail

DIARY_DIR="diaries"
ANALYZE="scripts/analyze_sentiment.sh"

mkdir -p "$DIARY_DIR"

# --- 날짜 입력 (기본: 오늘) ---
read -r -p "날짜 입력(YYYY-MM-DD, 기본: 오늘): " IN_DATE
if [ -z "${IN_DATE:-}" ]; then
  DATE="$(date +%F)"
else
  # 형식 검증 + 변환 시도
  if ! date -d "$IN_DATE" +%F >/dev/null 2>&1; then
    echo "[ERR] 날짜 형식이 올바르지 않습니다. 예) 2025-09-10"
    exit 1
  fi
  DATE="$(date -d "$IN_DATE" +%F)"
fi

FILE="${DIARY_DIR}/${DATE}.txt"
echo "[INFO] 일기 파일: $FILE"

echo
echo "입력 방법을 선택하세요:"
echo "  1) 터미널에서 바로 입력 (Ctrl+D로 종료)"
echo "  2) 편집기(EDITOR)로 작성 (${EDITOR:-nano})"
read -r -p "선택 (1/2, 기본 1): " MODE
MODE="${MODE:-1}"

if [ "$MODE" = "2" ]; then
  TMP="$(mktemp)"
  ${EDITOR:-nano} "$TMP"
  # 빈 파일 방지
  if [ ! -s "$TMP" ]; then
    echo "[WARN] 입력 내용이 비어 있어 저장하지 않습니다."
    rm -f "$TMP"
    exit 0
  fi
  mv "$TMP" "$FILE"
else
  echo "[INFO] 일기 내용을 입력하세요. (Ctrl+D로 저장)"
  cat > "$FILE"
fi

echo "[OK] 저장 완료: $FILE"
echo

# --- 분석만 실행 ---
if [ -x "$ANALYZE" ]; then
  "$ANALYZE"
fi

# # 최신 요약 표시
# if [ -s output/reports/summary_latest.txt ]; then
#   echo
#   echo "====== 최신 요약 ======"
#   cat output/reports/summary_latest.txt
# fi

# echo
# echo "[DONE] 결과:"
# echo " - 감정 리포트:   output/reports/sentiment_daily.csv"
# echo " - 최신 요약:     output/reports/summary_latest.txt"
