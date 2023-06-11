---
title: "Network Programming - TLS 서버 구축"
excerpt: "NP Post"

categories:
    - NetworkProgramming
tags:
  - [Network, TLS, Server]

toc: true
toc_sticky: true

date: 2023-06-11
last_modified_at: 2023-06-11
---
# TLS 통신
<details>
<summary>OpenSSL: https_simple.c</summary>
<div markdown='1'>

![image](https://github.com/ssoxong/ssoxong.github.io/assets/112956015/5d942e42-4f58-467a-9e1a-6b63ce7905b3)

</div>
</details>

<iframe
  src="https://carbon.now.sh/embed?bg=rgba%28171%2C184%2C195%2C0%29&t=vscode&wt=none&l=auto&width=680&ds=false&dsyoff=20px&dsblur=68px&wc=true&wa=true&pv=0px&ph=0px&ln=false&fl=1&fm=Hack&fs=14px&lh=133%25&si=false&es=2x&wm=false&code=%252F*%250A%2520*%2520MIT%2520License%250A%2520*%250A%2520*%2520Copyright%2520%28c%29%25202018%2520Lewis%2520Van%2520Winkle%250A%2520*%250A%2520*%2520Permission%2520is%2520hereby%2520granted%252C%2520free%2520of%2520charge%252C%2520to%2520any%2520person%2520obtaining%2520a%2520copy%250A%2520*%2520of%2520this%2520software%2520and%2520associated%2520documentation%2520files%2520%28the%2520%2522Software%2522%29%252C%2520to%2520deal%250A%2520*%2520in%2520the%2520Software%2520without%2520restriction%252C%2520including%2520without%2520limitation%2520the%2520rights%250A%2520*%2520to%2520use%252C%2520copy%252C%2520modify%252C%2520merge%252C%2520publish%252C%2520distribute%252C%2520sublicense%252C%2520and%252For%2520sell%250A%2520*%2520copies%2520of%2520the%2520Software%252C%2520and%2520to%2520permit%2520persons%2520to%2520whom%2520the%2520Software%2520is%250A%2520*%2520furnished%2520to%2520do%2520so%252C%2520subject%2520to%2520the%2520following%2520conditions%253A%250A%2520*%250A%2520*%2520The%2520above%2520copyright%2520notice%2520and%2520this%2520permission%2520notice%2520shall%2520be%2520included%2520in%2520all%250A%2520*%2520copies%2520or%2520substantial%2520portions%2520of%2520the%2520Software.%250A%2520*%250A%2520*%2520THE%2520SOFTWARE%2520IS%2520PROVIDED%2520%2522AS%2520IS%2522%252C%2520WITHOUT%2520WARRANTY%2520OF%2520ANY%2520KIND%252C%2520EXPRESS%2520OR%250A%2520*%2520IMPLIED%252C%2520INCLUDING%2520BUT%2520NOT%2520LIMITED%2520TO%2520THE%2520WARRANTIES%2520OF%2520MERCHANTABILITY%252C%250A%2520*%2520FITNESS%2520FOR%2520A%2520PARTICULAR%2520PURPOSE%2520AND%2520NONINFRINGEMENT.%2520IN%2520NO%2520EVENT%2520SHALL%2520THE%250A%2520*%2520AUTHORS%2520OR%2520COPYRIGHT%2520HOLDERS%2520BE%2520LIABLE%2520FOR%2520ANY%2520CLAIM%252C%2520DAMAGES%2520OR%2520OTHER%250A%2520*%2520LIABILITY%252C%2520WHETHER%2520IN%2520AN%2520ACTION%2520OF%2520CONTRACT%252C%2520TORT%2520OR%2520OTHERWISE%252C%2520ARISING%2520FROM%252C%250A%2520*%2520OUT%2520OF%2520OR%2520IN%2520CONNECTION%2520WITH%2520THE%2520SOFTWARE%2520OR%2520THE%2520USE%2520OR%2520OTHER%2520DEALINGS%2520IN%2520THE%250A%2520*%2520SOFTWARE.%250A%2520*%252F%250A%250A%2523include%2520%253Csys%252Ftypes.h%253E%250A%2523include%2520%253Csys%252Fsocket.h%253E%250A%2523include%2520%253Cnetinet%252Fin.h%253E%250A%2523include%2520%253Carpa%252Finet.h%253E%250A%2523include%2520%253Cnetdb.h%253E%250A%2523include%2520%253Cunistd.h%253E%250A%2523include%2520%253Cerrno.h%253E%250A%250A%2523include%2520%253Cstdio.h%253E%250A%2523include%2520%253Cstring.h%253E%250A%2523include%2520%253Cstdlib.h%253E%250A%2523include%2520%253Ctime.h%253E%250A%250A%2523include%2520%253Copenssl%252Fcrypto.h%253E%250A%2523include%2520%253Copenssl%252Fx509.h%253E%250A%2523include%2520%253Copenssl%252Fpem.h%253E%250A%2523include%2520%253Copenssl%252Fssl.h%253E%250A%2523include%2520%253Copenssl%252Ferr.h%253E%250A%250A%2523define%2520ISVALIDSOCKET%28s%29%2520%28%28s%29%2520%253E%253D%25200%29%250A%2523define%2520CLOSESOCKET%28s%29%2520close%28s%29%250A%2523define%2520SOCKET%2520int%250A%2523define%2520GETSOCKETERRNO%28%29%2520%28errno%29%250A%250A%250Aint%2520main%28int%2520argc%252C%2520char%2520*argv%255B%255D%29%2520%257B%250A%250A%2520%2520%2520%2520%252F*OpenSSL%2520%25EC%2582%25AC%25EC%259A%25A9%2520%25EC%25A0%2584%2520%25EC%25B4%2588%25EA%25B8%25B0%25ED%2599%2594*%252F%250A%2520%2520%2520%2520SSL_library_init%28%29%253B%250A%2520%2520%2520%2520%250A%2520%2520%2520%2520%252F%252F%25EC%2582%25AC%25EC%259A%25A9%25ED%2595%25A0%2520%25EC%2595%258C%25EA%25B3%25A0%25EB%25A6%25AC%25EC%25A6%2598%2520%25EB%25AA%25A8%25EB%2591%2590%2520%25EB%25B6%2588%25EB%259F%25AC%25EC%2598%25A4%25EA%25B8%25B0%250A%2520%2520%2520%2520OpenSSL_add_all_algorithms%28%29%253B%250A%250A%2520%2520%2520%2520%252F%252FOpenSSL%25EC%2597%2590%25EC%2584%259C%2520%25EC%2597%2590%25EB%259F%25AC%2520%25EB%25A1%259C%25EB%2593%259C%25ED%2595%2598%25EA%25B8%25B0%2520-%253E%2520%25EC%2597%2590%25EB%259F%25AC%2520%25EC%25B2%2598%25EB%25A6%25AC%25EC%2597%2590%2520%25EC%259D%25B4%25EC%259A%25A9%250A%2520%2520%2520%2520SSL_load_error_strings%28%29%253B%250A%250A%2520%2520%2520%2520%252F%252FSSL%2520Conetxt%2520%25EB%25A7%258C%25EB%2593%25A4%25EA%25B8%25B0%2520-%2520%25EC%2595%2594%25ED%2598%25B8%25ED%2599%2594%25ED%2582%25A4%252C%2520%25EC%259D%25B8%25EC%25A6%259D%25ED%2582%25A4%2520%25EC%25A0%2580%25EC%259E%25A5%2520%25ED%259B%2584%2520connection%25EB%258F%2599%25EC%2595%2588%2520%25EC%259C%25A0%25EC%25A7%2580%250A%2520%2520%2520%2520%252F%252FSSL_CTX_new%2520%25ED%258C%258C%25EB%259D%25BC%25EB%25AF%25B8%25ED%2584%25B0%25EB%25A1%259C%2520%25ED%2595%2598%25EB%2582%2598%25EB%25A7%258C%2520%25EB%2593%25A4%25EC%2596%25B4%25EA%25B0%2588%2520%25EC%2588%2598%2520%25EC%259E%2588%25EC%259D%258C%250A%2520%2520%2520%2520%252F%252FTLS_client_method%28%29%2520-%253E%2520TLS%2520%25EC%2582%25AC%25EC%259A%25A9%25ED%2595%259C%25EB%258B%25A4..%250A%2520%2520%2520%2520SSL_CTX%2520*ctx%2520%253D%2520SSL_CTX_ne"
  style="width: 720px; height: 3964px; border:0; transform: scale(1); overflow:hidden;"
  sandbox="allow-scripts allow-same-origin">
</iframe>

1. SSL 초기화

```c
/*OpenSSL 사용 전 초기화*/
SSL_library_init();

//사용할 알고리즘 모두 불러오기
OpenSSL_add_all_algorithms();

//OpenSSL에서 에러 로드하기 -> 에러 처리에 이용
SSL_load_error_strings();
```

2. SSL context 만들어서 TLS 선언

```c
//SSL Conetxt 만들기 - 암호화키, 인증키 저장 후 connection동안 유지
//SSL_CTX_new 파라미터로 하나만 들어갈 수 있음
//TLS_client_method() -> TLS 사용한다..
SSL_CTX *ctx = SSL_CTX_new(TLS_client_method());
```

3. TCP connection 후, TLS connection 연결

```c
/*initiate TLS connection*/
//SSL object 생성
//만든 객체로 connection tracking 가능
SSL *ssl = SSL_new(ctx);
if (!ctx) {
    fprintf(stderr, "SSL_new() failed.\n");
    return 1;
}

//서버에 도메인 세팅
//선택사항이지만, 없으면 여러 사이트에서 어떤 곳에 인증서를 보낼지 모름
if (!SSL_set_tlsext_host_name(ssl, hostname)) {
    fprintf(stderr, "SSL_set_tlsext_host_name() failed.\n");
    ERR_print_errors_fp(stderr);
    return 1;
}

//TCP connection에 SSL 붙이기
SSL_set_fd(ssl, server);
if (SSL_connect(ssl) == -1) {
    fprintf(stderr, "SSL_connect() failed.\n");
    ERR_print_errors_fp(stderr);
    return 1;
}
/*TLS connection end*/
```

4. 읽기 / 쓰기

```c
SSL_write()
SSL_read()
```

5. 할당 해제

```c
//연결 끊기
SSL_shutdown(ssl);
CLOSESOCKET(server);
SSL_free(ssl);
//할당 해제
SSL_CTX_free(ctx);
```

6. 사용한 알고리즘 리스트

```c
SSL_get_cipher(ssl);
```

7. Cipher and Certificate

```c
//접속한 서버의 인증서 가져오기
X509 *cert = SSL_get_peer_certificate(ssl);
if (!cert) {
    fprintf(stderr, "SSL_get_peer_certificate() failed.\n");
    return 1;
}

char *tmp;
//인증서 정보 가져오기
if ((tmp = X509_NAME_oneline(X509_get_subject_name(cert), 0, 0))) {
    printf("subject: %s\n", tmp);
    OPENSSL_free(tmp);
}

if ((tmp = X509_NAME_oneline(X509_get_issuer_name(cert), 0, 0))) {
    printf("issuer: %s\n", tmp);
    OPENSSL_free(tmp);
}

X509_free(cert);
```

8. complie

```bash
gcc https_simple.c -o https_simple -lssl -lcrypto
```

https 프로토콜을 이용하여 웹서버로부터 데이터를 가져오는 클라이언트 코드이다. 

# TLS 서버 구축
인증서를 직접 만들 수 있다.  
- 직접 만든 것이기에 self-sign  
- subject name == issure name 동일

<details>
<summary> TLS Server </summary>
<div markdown='1'>

![image](https://github.com/ssoxong/ssoxong.github.io/assets/112956015/01322c97-332e-46cf-861d-7d6b12453fa4)


</div></details>

끝..