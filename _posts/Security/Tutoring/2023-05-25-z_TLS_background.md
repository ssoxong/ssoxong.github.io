---
title: "[정보보안] TLS_Background"
excerpt: "Tutoring Post"

categories:
- Tutoring
tags:
- [네트워크]

toc: true
toc_sticky: true

---

# 2. Background

### OSI 7 Layer

### TCP/IP Protocol

| Applicaion | 페이로드 | message |
| --- | --- | --- |
| Presentation | 페이로드 | message |
| Session | 페이로드 | message |
| Transport | 프로토콜(TCP/UDP) | segment |
| Network | IP | packet |
| Data Link | MAC | frame |
| Physical | 아날로그 신호 |  |

표준이며, 개념적인 모델

| Application | HTTP / SMTP(메일) |
| --- | --- |
| Transport | TCP/UDP |
| Internet | ICMP / ARP / IP |
| Network Interface (Physical + DataLink) |  |

실제 모델

message - application data

segment - message를 쪼갠 것에 TCP/UDP 헤더 붙이기

packet - segment에 IP 헤더 붙이기

frame - packet에 MAC 헤더 붙이기 

### Link Encryption

암호화가 모든 링크에서 독립적으로 수행됨

모든 링크간의 사전에 공유된 키 필요

→ 데이터 자체를 암호화 하는 게 아닌 접근제한 느낌 (ex, wifi pwd)

### End-to-End Encryption

종단간 암호화, Client가 또다른 Client에게 보낸 정보는 도착할때 까지 계속 암호화 된 상태

헤더 말고 data를 암호화하는 형태

헤더에는 통신을 위한 데이터 (IP src, dst ..등) 들어있으니 암호화하지 않음

→ 트래픽 분석은 가능함

- 트래픽 분석도 싫다!!

VPN - src↔VPN Server만 보임 (IPSec 이용)

Deep Web - 여러 경로 거쳐서 보냄 (내부고발을 위해 고안됐으나 잡기 어려워 범죄에 악용)

![image](https://github.com/ssoxong/ssoxong.github.io/assets/112956015/e1aab1f9-82e8-48a0-bbf2-52a9d3464df6)

end-to-end로 헤더 보고 패킷 라우팅

→ 트래픽은 노출

트래픽을 link encryption으로 암호화

+ 메세지 인증을 위해 네트워크 패킷에 메세지 인증 알고리즘도 적용되어야 한다.

### 카카오톡,,

- 일반채팅

![image](https://github.com/ssoxong/ssoxong.github.io/assets/112956015/81cbb14e-bdb9-4efa-bc6d-4649c764eaff)
Server와 end-to-end 통신

서버는 메세지 볼 수 있으나, 중간의 라우터, wifi는 메세지 못 봄

- 비밀채팅

![image](https://github.com/ssoxong/ssoxong.github.io/assets/112956015/4bcff689-a40a-41df-82ee-4c4267dc4039)

A와 B 사이 end-to-end 암호화

메세지는 서버도 모름

서버와 클라이언트 사이 TLS통신이 이루어지고있는 동시에, A와 B사이에도 이루어져있음

