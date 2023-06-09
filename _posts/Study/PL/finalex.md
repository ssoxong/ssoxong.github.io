
PL 기말고사
범위: 8, 9, 10, 13, 14, 15, 16

# 1장
컴퓨터가 어떻게 작동하는지 프로그램 실행방법 3가지  
컴파일러, 인터프리터, 하이브리드 CPU와 메모리

# 2장
언어의 역사

# 3-4장
컴파일러 관련 언어의 문법 표현 방식  
lexeme 찾으면서 syntax anaylsis.. 등

# 5장
변수의 scope(범위)  
- Static: 프로그램 구조상 결정됨  
- Dynamic: 프로그램 실행 중 active 한 모든 변수

# 6장
변수의 Lifetime

# 7장
expression과 배정문

# 8장
제어문
selection, iteration  
iteration
1.	counter
2.	logic expression
3.	data structre

 [8.1] 복귀주소, 정적링크, 동적링크, 매개변수를 활성화 레코드의 하단부에 놓는 이유는 무엇인가?
일반적으로 처리기가 한 자료를 참조하기 위해서 그 자료가 속해있는 활성 레코드의 시작주소와 오프셋을 사용하기 위해
■ [8.2] 정적체인이 사용되었을 때, 비지역 변수의 참조를 찾는 방법을 설명하고, 이 방법에 있어서 두 개의 잠재적인 문제점은 무엇인가?
     비지역 변수의 참조 2단계 접근 과정
     1. 그 변수가 할당된 스택에 있는 활성화 레코드의 사례를 찾음
     2. 변수의 지역_오프셋을 사용하여 변수를 접근
     활성레코드의  발생,  소멸시  디스플레이  내용  변환
     간격  만큼  정적  링크  추적 ( 간격이  클때는  실행시간  낭비)
■ [8.5] algol 유사 언어의 한 블록이 활성화될 때 활성 레코드의 동적 링크와 정적 링크 값이 동일한 경우가 발생하는 때는 어느 경우인가?
  - 정적 내포관계에서 자식 프로시저를 호출하는 경우
 
■ [8.6] 정적 영역 규칙을 따르는 언어에서 비지역 변수의 참조는 참조경로를 유지하는 테이블인 디스플레이를 가지고 수행할 수 있다. 이 테이블을 항상 최근 상황으로 유지하기 위해 프로그램의 entry와 exit에서 수행되어야 할 알고리즘을 작성하라.
  - ① 추가시(enrty)
int current_index = 0;
int block_no =0;
int[] static_link;
int[] dynamic_link;
Active_rec[] active_rec;   //활성화 레코드
class Active_rec {
   String bloc_id;
   int offset;
   Display display;
}
class Display {
   int current_index;
   int[] parent_index;
}
Active_rec[] active_rec;   //active record 스택
//특정 active_rec을 active_rec[] 에 추가할 경우
void addRecord(Active_rec my_active_rec) {
   offset = my_active_rec.offset;
   current_index = block_no -1;
   //active_rec 에 객체가 존재하는 지
   if(active_rec != null) {
      //존재하지 않으면 그냥 추가만
      //초기화
      active_rec.block_id = block_id;
      active_rec.display.current_index = offset;
   } else {   //기존 활성화 레코드가 존재할 경우
                 //current_index = block_no 1; //currnet 위치 index는 블록의 개수
                 if(block_no == 0) { //block이 없는 경우
         System.exit(1);
                 }
                 active_rec.display.current_index = offset;
                 for(int i=0; i< static_link.length; i++)
                    for(int j=0; j<active_rec.length; j++)
                       for(int k=0; k< active_lec[j].display.parent_index.length; k++) {
                          if(active_rec.display.block_id == static_link[i] ) {
                             active_rec[j].display.parent_index[k] = static_link[i];
                          }
                      }
   }
}
 
    ② 삭제시(exit)
int current_index = 0;
int block_no =0;
int[] static_link;
int[] dynamic_link;
Active_rec[] active_rec;   //활성화 레코드
class Active_rec {
   String bloc_id;
   int offset;
   Display display;
}
class Display {
   int current_index;
   int[] parent_index;
}
Active_rec[] active_rec;   //active record 스택
void delRecord(Active_rec my_active_rec) {
   offset = my_active_rec.offset;
   current_index = block_no -1;
   //active_rec[] 에 객체가 존재하는 지
   if(active_rec != null) {   //존재하지 않으면 빠져나간다.
      System.exit(1);
   } else {   //기존 활성화 레코드가 존재할 경우
         //current_index = block_no 1;   //currnet 위치index는 블록의 개수
         if(block_no == 0) {   //block이 없는 경우
            System.exit(1);
         }
         active_rec.display.current_index = offset;
         for(int i=0; i< static_link.length; i++)
            for(int j=0; j<active_rec.display.parent.length; j++) {
               if(my_active_rec.block_id == static_link[j] ) {
     active_rec.display.current_index = my_active_rec.offset;
     active_rec.display.parent_index[j] = active_rec.display.parent_index[j++];
               }
            }
   }
}
 
■ [8.7] 동적변수(dynamic variable)를 사용할 수 있는 언어에서는 힙 기억장소 할당 기법을 사용하게 되는데, 이 경우의 장단점과 기억 장소 할당 및 회수 알고리즘을 논하라.
  - ① 장점: 동적 변수를 할당할 때 만약 힙 공간을 쓰지 않는다면 불가능하다. 힙은 활성 레코드 영역에 넣을 수 없는 동적 변수를 할당하고 사용할 수 있도록 하는 장점을 가진다.
     ② 단점: 활성 레코드에 할당되는 메모리 공간은 함수 리턴 과정에서 활성 레코드가 소멸되기 때문에 따로 해제하는 과정이 필요하지 않으나, 힙에 할당된 동적 변수는 명시적으로 할당해야 한다는 단점이 있다. 만약 계속해서 힙의 공간을 해제하지 않는다면 메모리 사용이 비효율적이거나, 힙 공간이 부족해질 수 있는 단점이 있다.
     ③ 할당 알고리즘: 힙 공간이 부족할 경우 힙 기억장소 회수 알고리즘을 동작시키며, 그렇지 않을 경우 적당한 기억장소를 할당하고 그 시작주소를 반환한다.
   ④ 회수 알고리즘: 충분한 기억장소를 확보할 때까지 이미 종료된 프로세스에서 사용되었던 변수들을 해제한다.
 
■ [8.8] 정적영역 규칙을 따르는 언어에서 부프로그램 호출 시 실행시간 스택에 활성 레코드를 할당하고 회수할 때, 동적 링크와 정적 링크를 유지하는 알고리즘을 작성하라.
  - 알고리즘: 동적 링크의 할당과 회수는 스택의 동작과 일치한다. 따라서 이 동적 링크와 정적 링크를 동시에 유지하려면 동적 링크를 기본으로 정적 링크를 따로 관리한다.
int[] element;   //동적링크 관리 배열
class Active_rec {
   int current_index;
   int offset;   //정적 포인터
}
//활성화 레코드를 스택에 쌓는 것과 동시에 정적 포인터를 이용해 부모 블록을 가리키게 한다.
protected void push(Active_rec data) {
   if(used < max_size) element[used++] = data;
   else System.out.println( "ERROR : STACK is full");
}
//활성화 레코드를 스택에서 삭제함과 동시에 정적 포인터를 이용해 삭제된 부모 블록의 다음 //블록을 가리키게 한다.
protected void pop() {
   if(used > 0) used—;
   else System.out.println("ERROR : STACK is empty")
}
public void allocation() {
push(active_rec);
}
public void delete() {
pop();
}
 
■ [8.9] 다음 골격 프로그램의 지점 1에 실행이 도착했을 때, 정적체인과 동적체인이 포함된 모든 활성 레코드 스택을 보이시오. 단, BIGSUB의 레벨은 1이라고 가정한다.
  - A → B → A → C → D             


# 9장
prcess / data 추상화   
함수의 파라미터에 관힌 이야기 

## parameter profile
actual, formal 파라미터 -> 호출자와 피호출자 관계  
- send-receiver
- client-server

## function / procedure
둘 다 category of subprogram  

함수
- 수학을 모델링 한 것
- 명시적인 리턴값이 존재한다.

프로시저
- 리턴값이 존재하지 않는다. 

--> 함수에서도 리턴값을 없애 프로시저처럼 할 수 있으므로, 프로시저를 분리된 형태라고 보지 않는다.

프로시저의 결과 생성
1. formal parameter로 받지는 않았지만 전역변수같은 거 존재하면 변경할 수 있다.
2. formal parameter가지고 있으면 바꿀 수 있다.  
-> 전역변수 고치기, call-by-reference

- call by reference  
    aliasing 발생  
    side effect 발생 -> module coupling

9.3 design issue  
p402 in/out  
p408-그림 9.2	value와 ref의 차이점은 값을 넘겨서 복제하느냐 주소를 넘기느냐 차이  
9.9	오버로딩  
9.10 Generic Ploymorphism, 자신의 자손 클래스의 instancce에 upcasting 형식으로 접근할 수 있음  
p430	연산자 +, -, *, .... 등은 기본적으로 오버로드 되어있다  
closure?: 함수 언어에 사용하는 것, 함수 안에 함수 선언시 noname(annonymous)형태로 파라미터 컴기는 것  
434 coroutine  
그림 9.3, 9.4	resume: 서있던 걸(멈춰 있던걸) 다시 실행시킴  
control이 B에게 넘어감  
resume A -> resume B한 다음으로 넘어감  



# 9장 다시보기
### IN/OUT
in
- call by value

out
- call by result

inout
- call by reference(주소값 넘기기)

out은 inout의 subset이나 명시적으로 구현하는 언어도 있음..
out/inout: side effect 존재함

### Overloading
int facotorial(int)
float factorial (float)

### Ploymorphism
다형성 - 여러가지 형태를 가질 수 있다

함수가 여러 type의 데이터를 받을 수 있어야 polymorphic한 것.
하지만 typecheck를 함으로 같은이름 다른타입 여러개 overload하여 구현함.
--> 사용자로에게는 다형성 제공

- overloading
- catch(Exception e) -> 모든 예외 처리 가능


# 총요약!!!!!!!!!
## 1장
컴퓨터가 어떻게 작동하는가
프로그램 실행방법 3가지 - 컴파일, 인터프리터, 하이브리드
CPU와 메모리

## 2장
언어의 역사

## 3-4장
컴파일러 관련
언어의 문법을 어떻게 표현하느냐
컴파일한다는 것은 
1. lexmem 찾으면서 syntax anaylsis
lexe|parser
top-down / 바텀엄

## 5장
변수의 Scope

## 6장
Lifetime

## 7장
식과 배정문

## 8장
제어문

## 9장
함수의 파라미터에 관한 이야기
397 -> procedure / function 차이
9.3 -> design issue
402 -> in/out
408의 그림 9.2 -> value와 reference의 차이는 값을 넘기느냐 주소를 넘기느냐..
subprogram을 파라미터로 넘기기(포인터로)
9.9 -> 오버로딩
9.10 -> Generic
Ploymorphism..
자신의 자손 클래스의 instance에 접근......
430 -> 연산자 +, -, * ...등은 기본적으로 오버로드 되어있음
closure? -> 함수언어에서 사용하는 것.. 함수안에 함수 선언시 noname(annonymous) 형태로 파라미터로 넘기는 것
coroutine 434

![image](https://github.com/ssoxong/ssoxong.github.io/assets/112956015/92cf5a26-2b66-4513-9b44-f6b96553b13d)


resume - 서있던걸 다시 실행시킴
control이 B로 넘어감
Resum A -> resum B한 다음으로 넘어감
