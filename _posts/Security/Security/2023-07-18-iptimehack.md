---
title: "iptime 공유기 펌웨어 해킹 (N604SE)"
excerpt: "Security Post"

categories:
- Security
tags:
- [Security]

toc: true
toc_sticky: true

date: 2023-07-18
---

## 공유기 펌웨어 해킹
이라기 보다는 펌웨어를 뜯어서 쉘을 올리고 로그인 GUI를 출력하는 것이 목표  

## N604SE
실제로 사용하고 있는 iptime 모델의 펌웨어를 선택하였다.  
최신 버전이라 (2023.06) captcha 작동과 symbolic link 불완전함 등 아쉬운 점이 있지만 동일한 방식으로 다른 펌웨어(a1004v.. 등)을 실행하면 잘 된다!

## 준비물
1. iptime n604se 14.20.8 버전 펌웨어  
    http://iptime.com/iptime/?page_id=126&pageid=1&mod=document&keyword=n604se&uid=25253
2. 리눅스 환경  
3. binwalk, qemu 등등 설치 (sudo apt install ...)  
    qemu는 자신이 고른 펌웨어에 맞는 버전을 설치해주면 된다. (아키텍처 확인은 후술)

## binwalk
펌웨어 등 .bin 파일을 효율적으로 분석할 수 있게 해주는 도구이다.  

|옵션|기능|
|---|---|
||리눅스 커널 버전 등의 정보를 알 수 있다.
-e|바이너리 파일을 자동으로 분석해주고, 분리해준다.
-E|정보량의 엔트로피를 시각화한다.
-A|해당 펌웨어에 사용된 아키텍처를 알 수 있다.

## 진행 과정

### 1. 펌웨어 다운

```bash
wget http://download.iptime.co.kr/online_upgrade/n604se_ml_14_208.bin
```

### 2. 바이너리 파일 (.bin) 추출

```bash
binwalk -e n604se_ml_14_208.bin
```

-e 옵션은 -extract와 동일한 역할을 하며, (바이너리 파일).extracted 이라는 폴더를 생성한다.  

해당 폴더 내에는 펌웨어의 구성정보가 들어있으며, 하나하나 탐색해서 펌웨어의 정보를 획득할 수 있다.


![image](https://github.com/ssoxong/add-nbo/assets/112956015/bba67cfd-d931-4e36-9bab-ffd66c1fa051)

파일을 추출 후, ls명령어를 이용해 어떤 파일이 들어있는지 확인할 수 있다.

- 150000.squashfs 분석

![image](https://github.com/ssoxong/add-nbo/assets/112956015/c097c0b3-50c3-4133-8df9-afe95525144f)

엔디안과 사이즈 제외, 별로 얻을 수 있는 정보가 없다.  
해당 게시글에서는 qemu를 가상환경으로 돌려서 분석하지 않을 거지만, 해당 방법으로 하실 분들은 endian을 맞춰주는 것이 중요하다.

- 40  

![image](https://github.com/ssoxong/add-nbo/assets/112956015/cfbd2a64-8a01-451c-ac4e-f6c6c458996d)

리눅스 커널 버전을 알 수 있다!  

해당 파일의 아키텍처를 알아보면 펌웨어가 어떤 아키텍처를 기반으로 개발되었는지 알 수 있다. (정확한 정보인지는 모르겠으나..)

```bash
binwalk -A 40
```

![image](https://github.com/ssoxong/add-nbo/assets/112956015/728fbf82-e66b-4e2c-a01a-580f0fff3358)

해당 펌웨어는 MIPSEL 기반인 것을 확인할 수 있다. (MIPS와 다름)  

간혹 다른 아키텍쳐가 조금씩 섞여 나오는 경우가 있는데, qemu를 실행할 때는 때는 가장 많이 나오는 아키텍쳐를 기반으로 구동시켜야한다.  

```bash
binwalk -AE 40
```

명령어로 어떤 아키텍처가 사용됐는지 엔트로피를 그릴 수 있는데, 해당 펌웨어에서는 MIPSEL이 99.9%, MIPS가 0.1%정도 나와 그냥 MIPSEL로 진행했다.

- squashfs-root

![image](https://github.com/ssoxong/add-nbo/assets/112956015/4706311a-0689-40d8-b874-31a0fe4212fc)

우리가 이제 가장 많이 들락날락거려야 할 디렉토리이다!  
보면 알겠지만 리눅스와 동일한 구조의 디렉토리다.  

대부분의 정보는 etc에 존재한다. 

또한 default 폴더의 내용을 tmp라는 폴더에 복사해주자!  

```bash
sudo cp -r ./default/* ./tmp/
```

분석을 실행하며 이것저것 건들기 떄문에 tmp폴더를 새로 생성하여 복사해준다.  
하지만 굳이 필요한 동작은 아닌듯..?

### 3. Shell 실행

squashfs-root 디렉토리 경로에서 해당 명렁어를 실행한다. 


```bash
chroot . ./usr/bin/qemu-mipsel-static /bin/sh
```

![image](https://github.com/ssoxong/add-nbo/assets/112956015/5cf7d27e-926c-4785-8139-6942964d1fac)

chroot - change root  
현재 디렉토리(.)를 qemu를 통해 루트권한을 부여하고 /bin/sh를 실행한다. 

qemu가 설치되어있는 경로를 지정해주면 된다. 


### 4. 이것저것 뜯어보기
- 관리자 ID/PW  

![image](https://github.com/ssoxong/add-nbo/assets/112956015/3f5b9731-da0f-4566-8d2d-74c37affad1e)

default/etc 폴더에 passwd.ated를 통해 확인할 수 있다.  

ID와 PW 또한 리눅스 구조로 저장되어있다.   

> 아이디:\$해시 알고리즘 번호\$salt값\$비밀번호 해시값  

추가적으로 설명을 덧붙이자면, 비밀번호 그대로를 해시하면 취약한 암호의 경우 바로 알 수 있기에 랜덤한 값을 비밀번호에 salt값을 추가하는 것이다.  

Hash(pw) -> Hash(pw+salt) 형태!

이렇게 하면 해시 최종 원본은 랜덤값이 되기 때문에 안전해진다.

번호 1은 MD5를 뜻한다.  
해시알고리즘은 해시값을 보고 원문을 거의 알 수 없다는 특징을 가지지만, MD5는 충돌성이 발견되어 취약하기에 일부 가능하다.  
(원래는 이러면 안됨..)  


따라서 어찌저찌 복호화하면 password 평문을 알 수 있다!  

사진은 따로 첨부하지 않겠지만 예상 가능한 그거다..

### 5. Login GUI 구동

```bash
./sbin/httpd
```

![image](https://github.com/ssoxong/add-nbo/assets/112956015/d32292f2-f824-48cf-9bf5-b824d053811a)

이 안된다!!  
httpd는 아파치 웹서버 관련 파일이고, 이 명령어를 입력하는 과정에서 펌웨어별로 다양한 오류메세지와 좌절을 경험할 수 있다.  

내가 만난 다양한 오류 중에서, "Could not open config file for reading"은 boa_vh.conf를 수정한 후 연동해주면 된다. 

https://alienx.tistory.com/7  

해당 블로그를 참조했다.

```bash
./sbin/httpd -s /tmp/var/boa_vh.conf
```

![image](https://github.com/ssoxong/add-nbo/assets/112956015/0da8ed17-0e95-49da-acb3-1da03d2112ee)

firefox에서 localhost로 접속시, 성공적으로 구동되는 것을 알 수 있다.

![image](https://github.com/ssoxong/add-nbo/assets/112956015/39bd95bd-1a59-47ae-9617-94563b54d2a4)


```bash
ps-ef | grep "httpd"
```

해당 명령어를 실행하여 httpd가 정말로 실행중인지 아닌지를 확인할 수 있다.  
만약 웹서버는 구동됐는데, grep에 잡히지 않을 시 실제로 펌웨어의 httpd가 실행중인 게 아닌 것이다.

더 확실하게 알 수 있는 방법은 ipTIME 옆의 버전을 확인하는 것이다.  
해당 게시글에서는 N604SE 모델의 펌웨어를 사용하였으므로, 정상적으로 나오는 것이다!


## 그 외 내가 만난 오류..
- illegal instruction  
-> 펌웨어 바꾸기 추천

- squashfs-root 폴더에 아무것도 없음  
-> 펌웨어 또는 펌웨어 '버전' 바꾸기 추천  
나같은 경우 또한 여러 버전의 n604se를 받아 확인 후 최종적으로 선택한 것이 이 버전.

- squashfs-root 폴더가 없고 다른 이름의 폴더에 리눅스 구조가 있다.  
-> 너무 옛날 펌웨어거나 너무 최신의, 비싼 버전의 펌웨어 사용했을 경우 발생  
2004년 모델의 펌웨어, 최신 30만원대 공유기 펌웨어에서 해당 경우발생함
  
- /dev/null 이 없다  
    -> vi /dev/null 한 후 아무 내용도 입력하지 않고 :wq
  

## 결론
최대한 다양한 펌웨어를 시도해보는 것을 추천드립니다.  

해당 방법은 다른 IoT의 펌웨어에서도 적용되는 것으로 알고있지만, 가장 쉬운 것이 ipTIME이기에.. 처음 해보시는 분들은 ipTME으로 방법 익힌 후 목표 펌웨어로 넘어가시는 것을 추천드립니다!  



시행착오도 많고 들인 시간도 많고 IoT 해킹에 대해 정말 아무것도 모른 상태에서 시작했지만 재밌었습니다~!