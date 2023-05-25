---
title: "2023-1 SW Tutoring - 개체 인증"
excerpt: "Tutoring Post"

categories:
- Tutoring
tags:
- [개체 인증, 인증]

toc: true
toc_sticky: true

---

## 2. 개체 인증

---

### 2.1 개체인증 개요

개체간의 인증 식별

특정 개체를 다른 개체에 인증하는 것

| Message Authentication(Data Origin) | Entitny Authentication |
| --- | --- |
| 실시간 아니어도 됨  | 실시간성 |
| 각 메세지마다 수행됨 | 한 번 수행된 후 일정 시간동안 유지됨 |
| 이메일을 통해 비밀번호 찾기 | 은행 사이트 한 번 로그인 하면 10분동안 유지 |

### 2.2 패스워드 기반 인증

가정: pwd DB에 저장했는데 DB가 탈취됨..

#### 패스워드 그대로 저장 → 유출시 위험

#### Hash(pwd) 저장 → 역상저항성으로 안전
- 사전 공격(Dictionary Attack) + pre-computation table

    흔한 패스워드를 미리 Hash한 후 사용자의 Hash값과 비교

    원래 역상을 찾기 위해서는 전수조사가 필요해 2^160의 노력이 필요함 (SHA1 기준)

    → 취약한 패스워드(흔한 패스워드) 쓰고 있으면 사전 공격을 통해 전수조사보다 빨리 알 수 있음
        
#### Hash(pwd||salt) 저장
- 사전 공격, pre-computation table에 안전

    취약한 pwd라고 해도 랜덤한 salt와 함께 Hash하니까 랜덤한 Hash값.

    salt를 알고있다고 하더라도 pre-computation table 사용 어려움

    → 사용하기 위해서는 hash(pwd||salt)값을 전부 구해야 하기 때문에 연산횟수는 동일

- salt 경우의 수도 고려해서 모든 경우의 수에 대한 해쉬값 저장 → pre-computation 만들기 어렵다…

#### 서버가 자신의 패스워드 알지 못하게..
1. Server → User (salt)
2. User → Server (hash(pwd||salt))

→ 둘 사이 통신에 기밀성과 인증이 제공되어야 한다.


**Q1. 왜 Salt를 사용하는지?**

**Q2. Salt가 공개값임에도 안전해지는 이유는?**

### 2.3 OTP 기반 인증

OTP - One TIme Password

매번 다른 난수를 사용한다.

사전 공격이나 재전송 공격 등으로부터 안전하다.

- 방식

| 동기화 | 비동기화 |
| --- | --- |
|  사용자로부터 어떤 값이 올지 서버가 알고있음,  | Challenge, Response 주고받는 방식, |
| - 동기화 - 사용자로부터 어떤 값이 올지 서버가 알고있음, OTP가 서버와 동기화됨 | OTP가 항상 서버와 동기화 될 필요 없음 |
|  사용자와 서버는 Seed 공유 후 동일한 패스워드 생성 (OTP) - 시간 동기화 hash(seed, T) - 이벤트 동기화 (Counter) hash(seed, C) → 주로하는 방식 | 질의-응답 방식 동기화 불필요, 통신량 증가 |

### 2.4 질의 응답 기반 인증

Challenge - Response

Challenge - Freshness 필요 → 타임스탬프, 난수 이용

- 타임 스탬프

A가 보낸 T와 B가 측정한 T가 비슷하면 통과

**—> 동기화된 time을 이용하므로 Challenge 불필요**

- 난수 - CTR 이용할 수 있지만 저장 자체 오버헤드

난수 재사용시 도청 공격에 무력


| 대칭키 | 타임스탬프 | 단방향 |
| --- | --- | --- |
|  | 난수 | 단방향 |
| 해쉬함수 | 타임스탬프 | 단방향 |
|  | 난수 | 양방향 |
| 공개키 | 난수 | 단방향 |
| 전자서명 | 타임스탬프 | 단방향 |
|  | 난수 | 양방향 |

- 해시 - 난수 - 양방향

A-B 사이 공유된 key list존재

수신한 hash와 자신이 key list 돌려가며 hash한 값 비교


### 2.5 차세대 인증

- 그래픽 기반 - CAPTCHA
- 인지 인증 - 이미지 등록
- 생체 인증 - BIOMETRICS - 지문, 목소리, 손모양, 서명…등등, AI기반 얼굴 인식

—> Liveness check 문제 (지문 위조), 정보 유출(bio 정보)

- 거리기반 인증 → 자동차 신호 Relay Attack

→ 근처에 가지 않아도 신호 relay attack으로 열림

—> 신호 발생 시간과 받은 당시 시간 비교해서 신호가 발생한 거리 측정 후 멀면 인증 통과 X

하지만 신호가 너무 빠름……… 그냥 신호를 느리게 하는 방법으로 변경

