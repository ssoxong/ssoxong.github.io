---
title: "Network Programming - Background"
excerpt: "NP post"

categories:
    - NetworkProgramming
tags:
  - [Network, Programming]

toc: true
toc_sticky: true
 
date: 2023-06-01
last_modified_at: 2023-06-01
---

## 네트워크
### 통신
- LAN (근거리 통신)
    스위치, 허브로 공유

- WAN (광역 통신)
    두개 이상의 근거리 네트워크가 넓은 지역에 걸쳐 연결되어 있음

### 통신 방식
서버 - 클라이언트
- 유니캐스트 (1:1)
- 브로드캐스트 (1:n)
    로컬 LAN(라우터로 구분된 공간)에 있는 모든 네트워크 단말기에 데이터를 보낸다.  

    MAC주소: FF-FF-FF-FF-FF-FF
- 멀티캐스트
    특정 그룹에 한번만 전송

유니캐스트 < 멀티캐스트 < 브로드캐스트

## 프로토콜
**컴퓨터와 컴퓨터 사이에서 메세지를 전달하는 과정**  

- 구문: 데이터의 구조나 포맷
- 의미: 전송되는 데이터의 각 부분이 무엇을 뜻하는지
- 순서: 어떤 데이터를 보낼 것인지 / 얼마나 빠르게 보낼 것인지

그 외, 주소 설정 / 순서 제어 / 데이터 대열의 단편화 및 재조합 / 캡슐화 / 연결 제어 / 흐름 제어 / 오류 제어 / 동기화 / 통신 서비스

## 네트워크 계층
### OSI 7 Layer
| Applicaion | 페이로드 | message |
| --- | --- | --- |
| Presentation | 페이로드 | message |
| Session | 페이로드 | message |
| Transport | 프로토콜(TCP/UDP) | segment |
| Network | IP | packet |
| Data Link | MAC | frame |
| Physical | 아날로그 신호 |  |

1. 물리 계층
    실제 장치를 연결하는 데 필요한 물리적 사항  
    ex. 허브

2. 데이터 링크
    점대점사이의 신뢰성 있는 전송 보장  

    ex. MAC, 이더넷, CSMA/CD  

    ex. 브리지, 스위치

3. 네트워크
    여러 노드를 거칠 때마다 경로 찾아줌  

    ex. IP, 라우팅
    - ARP(IP로 MAC 알아내기)
    -> ARP 자체는 L2에서 동작하나 L3과 연관된 정보가 필요함.
    따라서 L2와 L3을 연결해주는 프로토콜

4. 전송 계층
    양 끝단 사용자들이 신뢰성 있는 데이터를 주고받을 수 있게 함
    ex. TCP(연결 지향, 신뢰성) / UDP  


5. 세션 계층
    양 끝단의 응용 프로세스가 통신을 관리하기 위한 방법 제공
6. 표현 계층
    시스템에서 사용되는 코드간의 번역
7. 응용 계층
    사용자나 응용 프로그램 사이에 데이터 교환을 가능하게함  

    ex. HTTP / FTP

표준이며, 개념적인 모델  

### TCP/IP
| Application | HTTP / SMTP(메일) |
| --- | --- |
| Transport | TCP/UDP |
| Internet | ICMP / ARP / IP |
| Network Interface
(Physical + DataLink) |  |

## 네트워크 장비