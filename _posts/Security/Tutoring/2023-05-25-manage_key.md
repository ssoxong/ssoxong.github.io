---
title: "[정보보안] 키 관리"
excerpt: "Tutoring Post"

categories:
- Tutoring
tags:
- [키, KDC]

toc: true
toc_sticky: true

---

# 키 관리

![image](https://github.com/ssoxong/ssoxong.github.io/assets/112956015/4885c43c-db07-4b4b-857f-93400e1e93c8)

- 신뢰기관 이용 x -> pair-wise
- 대칭키 사전 주입 -> USIM 방식

## 키 분배 (대칭키 이용)
키 분배에 사용할 대칭키를 사전에 공유해야 함

### pair-wise
n(n-1)/2 개 필요, 사용자는 n-1개 관리  
peer-to-peer 기반, 신뢰되는 서버 없음

### 키 분배 센터(KDC)
KDC가 n개의 key 저장, 사용자는 1개 저장  
KDC를 무조건 신뢰해야 함

KDC에 Alice, Bob이 인증된 상태라면 둘 사이 비밀키를 KDC로 분배할 수 있다. 

![image](https://github.com/ssoxong/ssoxong.github.io/assets/112956015/f8f54a52-d9f4-456f-8276-fad7314d0ec4)


- 유심같은 건 KDC로 공유하지만 불특정 다수에게는 어려운 구조.

1. Alice, Bob 통신시 Alice가 Bob의 세션키 발급 요청
2. Bob 동의
3. KDC가 랜덤한 대칭키를 각자의 비밀키로 대칭키 암호화하여 양측으로 전송
4. 대칭키 복호화한 후 나온 비밀키로 Alice와 Bob의 통신

<br>

- 분산된 키 분배 센터
    - 평등 다중 구조  
    KDC 여러개가 flat하게 놓여져있는 형태  
    모든 KDC 사이에 사전에 공유된 대칭키가 존재해야 한다

- 계층 다중 구조  
    트리 형태로 키관리 cost 적음  

- Needham - Schreoeder 프로토콜

![image](https://github.com/ssoxong/ssoxong.github.io/assets/112956015/cd4e5f66-71d6-4218-9a2e-9efbf81b34b4)

$k_{AB}$를 이용한 재전송 공격 가능

→ Freshness 추가 (Timestamp)

- 커버로스
![image](https://github.com/ssoxong/ssoxong.github.io/assets/112956015/37b8b70c-0565-46b6-b355-adacfcb804cd)

티켓 이용, Timestamp 이용


## 키 교환 기술

client와 Server가 키에 부분적으로 기여하는것

- Diffie-Hellman 동의 프로토콜

g, p 는 서로 공유된 값  

$R_1 = g^x mod p$   
$R_2 = g^y mod p$

이렇게 통신하며 $g^{xy}$라는 대칭키 생성

$a^x = b (mod p)$에서 a, b, p가 충분히 크면 x를 찾기 어렵다는 점을 이용한다. 


→ 도청에는 강하나 중간자 공격에 취약  
도청해도 풀지를 못함

→ 키 교환시 인증서 사용해 g^a에 서명 + 자신의 인증서 (STS) 

- STS 프로토콜
![image](https://github.com/ssoxong/ssoxong.github.io/assets/112956015/1640c8c6-044c-4d23-b319-7834cc665d6b)

인증서, 서명을 통해 중간자 공격에 강함