---
title: "[데이터베이스] ER Diagram"
excerpt: "Data Base post"

categories:
    - Lecture
tags:
  - [Data Base]

toc: true
toc_sticky: true

date: 2023-06-12
last_modified_at: 2023-06-12
---

# ER Diagram
## 표현
- 네모: Entity Set
- 마름모: Relationship
- 화살표 없음: 1
- 화살표 있음: n
- 선 두개: 전부 포함
- 도형 이중선: weak

## 용어 
- weak entity  
    주 키가 없다.  
    테이블로 변경시 Strong의 도움을 받아야 한다.  
- multi-valued  
    한 개체당 여러 값을 가질 수 있는 속성이다.  
    보통 더블라인 타원으로 표현한다.  
    테이블로 변경 시 multi-valued만의 테이블을 생성하여 원래 entity의 주키를 가져와 표현한다.

## Entity -> Schema
### Basic Entity

<img src="https://github.com/ssoxong/ssoxong.github.io/assets/112956015/b72c8d96-67cc-4afb-bb14-8df658643ba4" max-width="60%" max-height="70%">

1. 약한 B는 일단 그대로 둔다.
2. Entity 이름으로 생성, 주키와 속성은 그대로

### Weak Entity
<img src="https://github.com/ssoxong/ssoxong.github.io/assets/112956015/f95b166b-d8a0-4d3e-a7de-ccad77239dd9" max-width="60%" max-height="70%">

Strong Entity의 주키와 자신의 부분키 동시에 주키로 생성한다.

### 1:1
<img src="https://github.com/ssoxong/ssoxong.github.io/assets/112956015/c09003ff-f8a3-4ab5-8988-bf39ae198526" max-width="60%" max-height="70%">

- 두개의 테이블  
E1(**A**, B, C, D)  
E2(**D**, E)

더블라인이 없다면 아무 개체에 속성 밀어도 됨  
E1(**A**, B)  
E2(**D**, E, C, A)  

두가지 방법 가능

- 세개의 테이블  
E1(**A**, B)  
E2(**D**, E)   
R(**A or D**, C)

### 1:N 

<img src="https://github.com/ssoxong/ssoxong.github.io/assets/112956015/77e8a4c5-8c65-4d69-9bc6-b1662a056df7" max-width="60%" max-height="60%">

- 두개의 테이블  
E1(**A**, B, C, D)  
E2(**D**, E) 
 
n쪽으로 밀기

- 세개의 테이블
E1(**A**, B)  
E2(**D**, E)   
R(**A**, D, C)  

n이 주키

### M:N
<img src="https://github.com/ssoxong/ssoxong.github.io/assets/112956015/f1bdbe18-aa13-4737-96e4-e7996e715f41" max-width="60%" max-height="60%">

E1(**A**, B)  
E2(**D**, E)  
R(**A**, **D**, C)  

### 다치 Attribute
<img src="https://github.com/ssoxong/ssoxong.github.io/assets/112956015/761d6531-b60c-4df6-97c3-ab71e586cd74" max-width="60%" max-height="60%">

다치 속성과 엔티티의 주키를 또다른 하나의 테이블의 키로 만든다.  

참고: https://m.blog.naver.com/PostView.naver?isHttpsRedirect=true&blogId=rjsdnrsla&logNo=221511575722

## 연습문제  
![image](https://github.com/ssoxong/ssoxong.github.io/assets/112956015/b0af5c35-0a48-408b-95c4-c6b869fe1329)

people(**pid**, name, addr, age)  
car(**vid**, make, model, year)  
own(**pid**, **vid**, rdata)

---

![image](https://github.com/ssoxong/ssoxong.github.io/assets/112956015/b488052d-b6bf-4233-8a75-d3179e99dbf2)

people(**pid**, name, addr, age)  
car(**vid**, make, model, year)  
own(pid, **vid**, rdata)


people(**pid**, name, addr, age)  
car(**vid**, make, model, year, rdata, pid)

---

![image](https://github.com/ssoxong/ssoxong.github.io/assets/112956015/66a17755-5b39-41ed-b3b6-dfe2075478d8)

people(**pid**, name, addr, age)  
car(**vid**, make, model, year)  
own(**pid or vid**, rdata)

people(**pid**, name, addr, age)  
car(**vid**, make, model, year, rdata, pid)

people(**pid**, name, addr, age, rdata, vid)  
car(**vid**, make, model, year)

---

<img src="https://github.com/ssoxong/ssoxong.github.io/assets/112956015/83bad1f9-144d-44d6-bee2-339c295eb1bd" max-width="60%" max-height="60%">

student(**sid**, sname)  
professor(**pid**, pname)
advise(**sid**, pid, time)

student(**sid**, sname, time, pid)  
professor(**pid**, pname)

---

<img src="https://github.com/ssoxong/ssoxong.github.io/assets/112956015/bae1a1ec-dbef-4ffa-aa3c-a26d1f77f17b" max-width="60%" max-height="60%">

people(**id**, name, addr)
fatherhood(fid, **cid**)  

people(**id**, name, addr, fid)

---

<img src="https://github.com/ssoxong/ssoxong.github.io/assets/112956015/99bd34e6-e52f-4d19-bb44-abfc6c45c8b4" max-width="60%" max-height="60%">

ship(**sid**, name, plant)  
sisterof(**sid, sisterid**)

---

<img src="https://github.com/ssoxong/ssoxong.github.io/assets/112956015/5d8c2e74-ab20-4271-9255-5083747180b1" max-width="60%" max-height="60%">

minimum table

branch(**bname**, city, assets)
loan(**loannum**, amount, baname)  
payment(**loannum, sequence**, date, amount)
