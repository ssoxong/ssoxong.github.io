---
title: "[네트워크 프로그래밍] TLS 서버 구축"
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
