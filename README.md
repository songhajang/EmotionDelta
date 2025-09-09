# EmotionDelta
하루의 감정을 기록하고, 나의 마음 상태를 되돌아보세요 :)

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

## 📝 프로젝트 주제 및 설명 (Project Description)





```
EmotionDelta/
├─ .sh # 메인 쉘스크립트
├─ .csv # 데이터 저장하는 곳
└─ README.md
```

---

## ⚙ 사용 기술 및 도구 (Tech Stack & Tools)

> **IDE / OS**: VS Code / Ubuntu 24.04 <br>
> **가상 환경**: VirtualBox (Linux VM 구동) <br>
> **버전 관리**: Git / GitHub <br>
> **협업**: Notion / Slack <br>

---

## 📝 이론 설명
### 📌 diff란?

`diff`는 두 파일을 비교해서 **무엇이 달라졌는지**, **추가/삭제된 내용**을 알려주는 Linux 명령어.

- `-` : 첫 번째 파일에서 삭제된 내용
- `+` : 두 번째 파일에 새로 추가된 내용

기본적으로 줄 단위로 비교되며, 옵션에 따라 단어 단위 비교도 가능함.

---

### 2️⃣ 주요 사용 명령어

#### 1. 기본 비교
```bash
diff file1.txt file2.txt
```

> 두 파일의 차이점 전체를 줄 단위로 보여줌

#### 2. 간단 비교 (다른지 여부만 확인)

```bash
diff -q file1.txt file2.txt
```

> 출력: "Files are different" 또는 "Files are identical"

#### 3. 통합(diff unified) 형식

```bash
diff -u file1.txt file2.txt
```

> 변경 부분 위/아래 문맥 포함
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

## 🖥️ 구현 기능 (Implemented Features)

- [x] 

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
