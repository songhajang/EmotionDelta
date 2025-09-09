
  <img width="200" height="200" alt="image" src="https://github.com/user-attachments/assets/289a952b-f88c-4837-bf7e-3a88224bfb9d" />

  
## 하루의 감정을 기록하고, 나의 마음 상태를 되돌아보세요 :)
하루 동안 느낀 감정을 간단히 기록하고 시각화하여 나의 마음 변화를 한눈에 확인할 수 있습니다.<br>
자신의 감정 패턴을 돌아보며 자기 이해와 정서 관리를 돕는 개인 맞춤형 기록을 제공합니다.

---

## 👥 구성원
<table>
  <tr>
    <td align="center">
      <a href="https://github.com/Minkyoungg0">
        <img src="https://github.com/Minkyoungg0.png" width="100px;" alt="Minkyoungg0"/><br />
        <sub><b>문민경</b></sub>
      </a>
    </td>
    <td align="center">
       <a href="https://github.com/GodNowoon">
        <img src="https://github.com/GodNowoon.png" width="100px;" alt="godnowoon"/><br />
        <sub><b>이노운</b></sub>
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/songhajang">
        <img src="https://github.com/songhajang.png" width="100px;" alt="songhajang"/><br />
        <sub><b>장송하</b></sub>
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/Gill010147">
        <img src="https://github.com/Gill010147.png" width="100px;" alt="Gill010147"/><br />
        <sub><b>황병길</b></sub>
      </a>
    </td>
  </tr>
</table>

## 📝 프로젝트 목표
**일일 감정 기록**: 사용자가 하루 동안 느낀 감정을 쉽고 빠르게 기록할 수 있도록 합니다. <br>
**마음 상태 시각화**: 기록된 감정을 차트나 그래프 형태로 시각화하여 나의 감정 패턴을 한눈에 파악하게 합니다.



## 📁 파일 구조
```
emotion-diff
├── diaries/                  # 일기 원본 텍스트 (날짜별 파일 저장)
│   ├── 2025-09-08.txt
│   ├── 2025-09-09.txt
│   └── 2025-09-10.txt
│
├── lexicon/                  # 감정 분석 사전
│   ├── positive_ko.txt       # 긍정 단어 리스트
│   └── negative_ko.txt       # 부정 단어 리스트
│
├── output/
│   ├── reports/              # 분석 결과물
│   │   ├── sentiment_daily.csv   # 날짜별 감정 점수 집계 (CSV)
│   │   ├── summary_latest.txt    # 최신 일자의 요약 결과
│   │   └── daily_diff.md         # 전일 ↔ 금일 감정 점수 비교 (diff 스타일 Markdown)
│   │
│   └── charts/ (optional)    # 감정 추이 그래프 (gnuplot 사용시 생성)
│       └── sentiment_trend.png
│
└── scripts/                  # 실행 스크립트 모음
    ├── write_diary.sh        # 일기 작성 → diaries/YYYY-MM-DD.txt 생성
    ├── analyze_sentiment.sh  # 모든 일기 분석 → sentiment_daily.csv/summary_latest.txt 갱신
    ├── plot_trend.sh         # CSV 기반 감정 추이 그래프 생성 → charts/sentiment_trend.png
    └── gen_md_diff.sh        # 전일 ↔ 금일 감정 점수 비교 → daily_diff.md (diff 명령어 활용)

```


### 📑 데이터 포맷

| 컬럼명 | 설명 | 예시 |
|--------|------|------|


---

## ⚙ 사용 기술 및 도구 (Tech Stack & Tools)

> **IDE / OS**: VS Code / Ubuntu 24.04 <br>
> **가상 환경**: VirtualBox (Linux VM 구동) <br>
> **버전 관리**: Git / GitHub <br>
> **협업**: Notion / Slack <br>

---

## 📝 이론 설명

### 📌 .sh 파일이란?
.sh 파일은 리눅스나 유닉스 환경에서 실행되는 스크립트 파일입니다.
주로 쉘(Shell) 명령어를 순서대로 작성해서 반복 작업을 자동화하는 데 사용됩니다.

공동 작업 환경에서 파일 및 디렉토리 접근 권한을 안전하게 제어하기 위한 **그룹 생성 → 사용자 추가 → 권한 설정** 절차입니다.  

### 실행과정

#### 1. 그룹 생성

작업 전용 그룹을 생성합니다.  
예시: `devgroup`

```bash
sudo groupadd devgroup
```

#### 2. 사용자 그룹 추가

협업 대상 사용자를 새 그룹에 등록합니다.

```
sudo usermod -aG devgroup user01
sudo usermod -aG devgroup ubuntu
```

> -aG: 기존 그룹 유지 + 새 그룹 추가
> 변경 사항은 로그아웃/로그인 후 적용됩니다.

#### 3. 파일 그룹 변경

대상 파일의 소유 그룹을 새 그룹으로 변경합니다.

```
sudo chgrp devgroup test.sh
```

#### 4. 그룹 권한 설정

> 소유자와 그룹에만 접근 권한을 부여합니다.

```
chmod 770 test.sh
```

> Owner (user01): rwx → 읽기/쓰기/실행
> Group (devgroup): rwx → 읽기/쓰기/실행
> Others: --- → 접근 불가

#### 5. 디렉토리 접근 권한 조정

파일 접근을 위해 상위 디렉토리에도 실행 권한을 부여해야 합니다.

```
sudo chgrp devgroup /home/user01
chmod 750 /home/user01
```
> r_x → 읽기/실행 권한 부여
<br>
---

### 📌 diff란?

`diff`는 두 파일을 비교해서 **무엇이 달라졌는지**, **추가/삭제된 내용**을 알려주는 Linux 명령어입니다.

- `-` : 첫 번째 파일에서 삭제된 내용
- `+` : 두 번째 파일에 새로 추가된 내용

기본적으로 줄 단위로 비교되며, 옵션에 따라 단어 단위 비교도 가능합니다.


### 주요 사용 명령어

#### 1. 기본 비교
```bash
diff file1.txt file2.txt
```

> 두 파일의 차이점 전체를 줄 단위로 보여줍니다

#### 2. 간단 비교 (다른지 여부만 확인)

```bash
diff -q file1.txt file2.txt
```

> 출력: "Files are identical" 또는 "Files are different"

#### 3. 통합(diff unified) 형식

```bash
diff -u file1.txt file2.txt
```

> 변경 부분의 위/아래 문맥을 포함합니다
> Git diff와 유사한 출력 형식


#### 4. 단어 단위 비교 (추가 설치 필요)

```bash
sudo apt install wdiff
wdiff file1.txt file2.txt
```

> 단어별 추가/삭제를 강조 표시

#### 5. 결과를 파일로 저장

```bash
diff file1.txt file2.txt > diff_result.txt
```

> 나중에 분석이나 시각화에 활용 가능

---

## 📷 프로젝트 시연

> 

---

## 👌트러블슈팅 (Troubleshooting)

| 문제 상황 | 원인 | 해결 방법 |
|-----------|------|-----------|
| 상황적기 | 원인적기 | 해결방법적기 |

---

## 📂 회고

- **민경** : 
- **노운** : 
- **송하** : 
- **병길** : 

---


<br>


## 향후 확장 가능성
- 
