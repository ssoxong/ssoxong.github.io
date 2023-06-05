---
title: "DB 연습문제"
excerpt: "Data Base post"

categories:
    - DB
tags:
  - [Data Base]

toc: true
toc_sticky: true

date: 2023-06-05
last_modified_at: 2023-06-05

use_math: true
---

# 6장 데이터 베이스 시스템 주요 기능

## View
사용자로부터 데이터 베이스 스키마 일부를 숨긴다.
```sql
create view myClub as {query}
```

뷰는 한개 이상의 테이블로부터 정의할 수 있으며, 해당 내용을 실제로 저장하지 않기 때문에 **virtual relation/table**이라고도 한다.

뷰는 항상 최신 데이터를 가지고있다.

뷰 정의시 다른 뷰를 사용할 수 있다.

자신의 뷰를 사용한 것은 순환뷰라고 한다.

뷰 질의가 들어오면, 뷰 정의로 치환 후 리턴하는 형식이다. 만약 뷰를 참조했다면 해당 뷰도 참조하고 참조하고 해서 최종적으로 베이스 테이블까지 접근한다.

뷰 입력, 삭제, 업데이트 가능하다.   

- 안되는 경우
1. 모호한 경우 (A와 B테이블 모두 id 속성을 가짐)
2. 집계함수 사용시 (avg, sum..)
3. group by, having, distinct, orderby, 집합연산 등


- 뷰 제약
1. 뷰는 실제 터플이 없기 때문에 index 불가
2. 뷰에 대해 키 속성 또는 무결성 제약 정의 불가

## Intergrity Constraints
데이터베이스 시스템이 항상 만족해야할 조건  
계좌 잔고는 무조건 100원 이상, 시급은 최저 600원부터.. 이런 제약 형식  

- 단일 테이블 제약
not null  
주키  
unique: 중복값 없으면 null 허용  
check 옵션
```sql
id char(3) not null
primary key (id)
check (id in ('1','2','3'))
```

- 참조 무결성 제약
외래키와 주키 관계 

```sql
foreign key(id) references person,
    on delete cascade,
    on update cascade
```

참조무결성 위반시 제약사항  
1. cascade
    삭제시 해당 터플을 참조하는 다른 테이블의 터플도 삭제한다.  
    수정시 다른 테이블도 같이 수정
2. set null
    삭제시 참조터플 null
3. set default

## Trigger
데이터 수정이 일어나면 side effect 자동 수행  
- ECA 규칙
사건 / 조건 / 행동으로 구성되며  
어떤 사건이 발생하면 조건을 평가하여 행동한다.  
사건 - 삽입/삭제/수정을 말함  

### Trigger 예제
1. 학생이 수업을 수강하여 학점을 취득하면 학생이 취득한 총 학점을 변경하는 트리거

```sql
Create trigger myCred after update of grade 
-- 업데이트 발생 시 업데이트 전과 후 참조
on takes referencing new row as nrow
referenceing new row as srow
referencing old row as orow
-- 값이 변경된 터플에 한해서만 조건을 확인한 후 행동한다
for each row
-- 변경 후의 학점이 F가 아니고 null도 아니면서, 변경 전 학점이 F이거나 null인 경우
when nrow.grade <> 'F' and nrow.grade is not null
and (orow.grade = 'F' or orow.grade is null)
-- 수강 과목의 학점을 학생 학점에 추가하는 형식
begin
    Update student
    set totalCredit = totalCredit + 
        (select credit
        from course
        where cID = nrow.cID)
    where sID = nrow.sID;
end;
```

2. 사용자의 계좌 잔고보다 더 많은 금액의 수표가 발생되는 경우 대출 계좌를 사용자 명의로 개설하고 초과된 만큼 대출금 설정

```sql
Create trigger myOverdraft after update on account
referenceing new row as srow
referencing old row as orow
for each row
-- 현재 계좌 잔고가 마이너스이면
when nrow.balance<0
-- atomic: 아예 실행하지 않거나 쿼리 3개 전부 실행한다
begin atomic
-- 조건에 맞는 터플과 은행 계좌가 동일한 예금주의 정보를 대출자 테이블에 넣기
    insert into borrower
    (select cName, aNumber from depositor
    where nrow.aNumber = depositor.aNumber);
-- 통장에서 마이너스 된 만큼 빚을 설정한다
    insert into loan values (nrow.aNumber, -nrow.balance);
-- 마이너스가 빚으로 처리되었으니 현재 잔고를 0으로 설정한다
    Update account set balance = 0;
        where account.aNumber = nrow.aNumber;
end
```

3. employee 관계의 salary 속성에 변경이 발생하면, department의 totalsalary를 변경한다.

```sql


## Authorization
## Recursive Queries


