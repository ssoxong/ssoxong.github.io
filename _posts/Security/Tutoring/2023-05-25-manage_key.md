---
title: "2023-1 SW Tutoring - 키 관리"
excerpt: "Tutoring Post"

categories:
- Tutoring
tags:
- [키, KDC]

toc: true
toc_sticky: true

---

# 키 관리

| 키 전송 프로토콜
(키 분배) | 신뢰 기관 이용 | 커버로스 프로토콜 등.. |
| --- | --- | --- |
|  | 신뢰 기관 이용 X | pair-wise |
| 키 공유 프로토콜
(키 교환) |  | 디피 헬만 프로토콜
STS 프로토콜 |
| 대칭키 사전 주입 |  | USIM,, |

### 키 분배 (대칭키 이용)

키 분배에 사용할 대칭키를 사전에 공유해야 함

사전 공유

- pair-wise

n(n-1)/2 개 필요, 사용자는 n-1개 관리

peer-to-peer 기반, 신뢰되는 서버 없음

- 키 분배 센터(KDC)

KDC가 n개 저장, 사용자는 1개 저장

KDC를 무조건 신뢰해야 함


1. Alice, Bob 통신시 Alice가 Bob의 세션키 발급 요청
2. Bob 동의
3. KDC가 랜덤한 대칭키를 각자의 비밀키로 대칭키 암호화하여 양측으로 전송
4. 대칭키 복호화한 후 나온 비밀키로 Alice와 Bob의 통신
- 분산된 키 분배 센터
    - (평등 다중 구조)
    모든 KDC 사이에 사전에 공유된 대칭키가 존재해야 한다

- 계층 다중 구조

키관리 cost 적음

- Needham - Schreoeder 프로토콜

![Untitled](9%E1%84%8C%E1%85%AE%E1%84%8E%E1%85%A1%20ce11272e8192406b98ae87d8b5b91f93/Untitled%203.png)

K(ab)를 이용한 재전송 공격 가능

→ Freshness 추가 (Timestamp)

- 커버로스
![image](https://github.com/ssoxong/ssoxong.github.io/assets/112956015/d4864959-4173-44a4-8d4d-baaf62d0609f)

티켓 이용, Timestamp 이용


### 키 교환 기술

client와 Server가 키에 부분적으로 기여하는것

- Diffie-Hellman 동의 프로토콜

g, p 는 서로 공유된 

지수법칙의 원리로 g^x mod p 결과를 전송함

1. Alice → Bob g^a mod p
2. Bob→ Alice g^b mod p
3. Alice - g^(a*b), Bob - g^(b*a) 대칭키 공유됨

→ 도청에는 강하나 중간자 공격에 취약

→ 키 교환시 인증서 사용해 g^a에 서명 + 자신의 인증서 

- STS 프로토콜

![Untitled](9%E1%84%8C%E1%85%AE%E1%84%8E%E1%85%A1%20ce11272e8192406b98ae87d8b5b91f93/Untitled%205.png)

인증서, 서명을 통해 중간자 공격에 강함