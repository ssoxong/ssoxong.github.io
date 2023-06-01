---
title: "Network Programming - TCP Server-Client"
excerpt: "NP post"

categories:
    - NetworkProgramming
tags:
  - [Network, Programming, Socket, Client, server]

toc: true
toc_sticky: true
 
date: 2023-06-01
last_modified_at: 2023-06-01
---
## TCP Server - Client
![image](https://github.com/ssoxong/ssoxong.github.io/assets/112956015/8855f141-b56a-4289-8889-ce875d4b59fe)

#### Server: listen()
클라이언트 접속 요청받음, 최대 접속 지정 가능

#### Client: connect()
클라이언트가 서버에게 접속

#### Server: accept()
접속한 클라이언트의 정보 제공

#### send(), recv() == write(), read()
send(fd, buf, len, flag)
recv(fd, buf, len, flag)
데이터 송수신용

<details>
<summary>실습 01: Basictcpsrv.c</summary>
<div markdowm="1">

```c
#include <stdio.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <string.h>
#include <arpa/inet.h>
#define PORT 9001

int main()
{
	//실제 소켓
	int srvSd, clntSd;
	//소켓의 주소 구조체
	struct sockaddr_in srvAddr, clntAddr;
	int clntAddrLen, readLen;
	char rBuff[BUFSIZ];
	char wBuff[] = "I am 20 years old.";
	
	//IPv4, TCP로 소켓 생성
	srvSd = socket(AF_INET, SOCK_STREAM, 0);
	if(srvSd == -1)
	{
		printf("Socket Error\n");
		return -1;
	}	
	
	//메모리 초기화
	memset(&srvAddr, 0, sizeof(srvAddr));
	srvAddr.sin_family = AF_INET;
	//INADDR_ANY: 어느 IP든 접속 가능
	srvAddr.sin_addr.s_addr = htonl(INADDR_ANY);
	//9001
	srvAddr.sin_port = htons(PORT);

	//소켓에 주소 설정해줌 (실제 소켓 <- 소켓 주소(sockaddr))
	if(bind(srvSd, (struct sockaddr *) &srvAddr, sizeof(srvAddr)) == -1)
	{
		printf("Bind Error");
		return -1;
	}

	//최대 5개 connection 허용
	if(listen(srvSd, 5) == -1)
	{
		printf("Listen Error");
		return -1;	
	}

	clntAddrLen = sizeof(clntAddr);

	//client로부터 연결 오면 clntSd 소켓에 저장 (clntSd는 할당된 fd 숫자임)
	clntSd = accept(srvSd, (struct sockaddr*)&clntAddr, &clntAddrLen);
	if(clntSd == -1)
	{
		printf("Accept Error");
		return -1;
	}
	
	//client가 write 값 읽기
	readLen = read(clntSd, rBuff, sizeof(rBuff)-1);
	if(readLen == -1) 
	{
		printf("Read Error");
		return -1;
	}
	//개행문자 추가
	rBuff[readLen] = '\0';
	printf("Client: %s \n", rBuff);
	
	//client로 값 보내기
	write(clntSd, wBuff, sizeof(wBuff));

	//소켓 닫기
	close(clntSd);
	close(srvSd);	
	
	return 0;	
}

```
</div>
</details>

<details>
<summary>실습 01: Bsictcpclnt.c</summary>
<div markdowm="1">

```c
#include <stdio.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <string.h>
#define PORT 9001

int main()		
{		
	//서버 소켓
	int clntSd;	
	struct sockaddr_in clntAddr;	
	int clntAddrLen, readLen;	
	char wBuff[] = "How old are you?";	
	char rBuff[BUFSIZ];	
		
	//IPv4, TCP로 소켓 생성
	clntSd = socket(PF_INET, SOCK_STREAM, 0);	
	if(clntSd == -1)	
	{	
		printf("Socket Creation Error");
		return -1;
	}	
	//주소 할당
	clntAddr.sin_family = AF_INET;	
	clntAddr.sin_addr.s_addr = inet_addr("127.0.0.1");	
	clntAddr.sin_port = htons(PORT);	
	
	//server(clntSd)에 연결 요청
	if(connect(clntSd, (struct sockaddr *) &clntAddr, sizeof(clntAddr)) == -1)			
	{	
		printf("Connect Error");
		close(clntSd);
		return -1;
	}	
		
		
	//보내기
	write(clntSd, wBuff, sizeof(wBuff));	
	printf("Client: %s\n",wBuff);	
		
	//읽기
	readLen = read(clntSd, rBuff,sizeof(rBuff)-1);	
	if(readLen == -1)	
	{	
		printf("Read Error");
		return -1;
	}	
	rBuff[readLen] = '\0';

	printf("Server: %s\n", rBuff);
	
	close(clntSd);
	return 0;
}	

```
</div>
</details>

## Q1. 서버 프로그램에서 최대 sizeof(rBuff)-1를 읽고 rBuff[readLen]에 '\0'을 추가하는 이유?
printf는 문장 종결 단위인 null을 만날 때까지 출력하기 때문에..

-> 널 추가하지 않으면 메모리 leak, 버퍼덮어씌워짐 등

혹은 null 추가 말고
```
printf("%.*s", readLen, rBuff);
```
형식으로도 가능

## Summary
- 네트워크 주소
    Network Classes (A/B/C/D..)
    CIDR

- 소켓 주소
    Bind

- 바이트 순서
    Network order = Big
    Host order = Little

- 주소 변환
    inet_*
    - addr = aton //ip to network
    - network //ip to host
    - ntoa //network to ip
    
    -- IPv6
    - pton //ip to network
    - ntop //network to ip  


    -- same
    - inet_addr() + ntohl() == inet_network()
    - inet_network() + htonl() == inet_addr()

- 소켓 프로그램
    **server**
    socket -> bind -> listen -> accept -> read/write -> close
   
   
    **client**
    socket -> connect -> read/write -> close