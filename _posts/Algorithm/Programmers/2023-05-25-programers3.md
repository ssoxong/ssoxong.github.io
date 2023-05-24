---
title: "Programmers - 숫자 짝꿍"
excerpt: "Programmers post"

categories:
    - Programmers
tags:
  - [Programmers], [Algorithm]

toc: true
toc_sticky: true

---
### 숫자 짝꿍
    
array.charAt(int index) → return char

array.charAt(int index)-’0’ → int형

Stirng s = “1234”;

s.charAt(2) =⇒ ‘3’

array[str.charAt(int index)]

‘3’의 아스키 코드 값 = 51
51-’0’(48)=3

Math.min(int a, int b)

- #### String Builder를 쓰지 않으면 시간 초과가 나는 이유?
    
    ---
    
    String은 불변 객체 → concat과 같이 문자열을 수정할 때 마다 메모리 새로 할당 필요
    
    StringBuilder는 가변 객체 → 처음부터 많은 공간을 차지하고 있음. append로 문자열 길이가 더 늘어나게 되어도 일정 수준 이하면 메모리 새로 할당할 필요 X
    
    문자열 길이가 할당된 공간보다 길어진다면 새로 복사 후 할당이 필요하지만 String보다는 현저히 적음
    
    —> StringBuilder는 capacity(Buffer size) ≠ length(버퍼에 들어있는 문자열 길이)  
    
    - #### String Buffer?
        
        StringBuffer도 StringBuilder와 마찬가지로 가변객체이며, String보다 빠른 것은 맞다.
        
        하지만 Buffer와 Builder의 차이점은 뭘까?
        
        StringBuffer은 동기화를 제공하고 StringBuilder는 동기화를 제공하지 않는다. 
        
        append 함수 구현 코드를 보면..
        
        ```jsx
        //StringBuilder
        public StringBuilder append(String str) {
            super.append(str);
            return this;
        }
        
        // StringBuffer
        public synchronized StringBuffer append(String str) {
            super.append(str);
            return this;
        }
        ```
        ![image](https://github.com/ssoxong/ssoxong.github.io/assets/112956015/501b74eb-b8ee-462d-8a4a-3912f68a8a89)
        
        - #### 동기화..?
            
            자바에는 thread개념 존재한다.  
            
            single thread - 프로그램 실행시 코드 한줄씩 하나씩 실행  
            
            multi thread - 하나의 코드를 다수가 중복 실행중
            
            ex) 여러 사람이 한 책을 동시에 읽음 - 내가 눈 감았다 뜬 사이에 책이 넘어가있을수도..?
            
            속도는 빠르지만 내가 처리하지 않아도 실행되어 있을 수도 있다.
            
            —> multi thread를 통한 간섭 최소화를 위한 기능 ⇒ 동기화
            
            동시에 동일한 메모리에 접근은 할 수 있지만, 동시접근시 순서대로 줄세워 하나씩 처리 (ex. 화장실)
            
            StringBuffer는 이러한 기능을 하는 동기화를 지원하기 때문에 극단적으로 보면 StringBuilder보다 느릴 수 밖에 없다!!

#### code
```java
class Solution {
    public String solution(String X, String Y) {
        String answer = "";
        int[] xarr = new int[10];
        int[] yarr = new int[10];
        
        for(int i=0;i<X.length();i++){
            xarr[X.charAt(i)-'0']++;
        }
        
        for(int i=0;i<Y.length();i++){
            yarr[Y.charAt(i)-'0']++;
        }
        StringBuilder sb = new StringBuilder();
        for(int i=9;i>=0;i--){
            int min = Math.min(xarr[i],yarr[i]);
            for(int a=1;a<=min;a++){
                if(sb.length()==0&&i==0)
                    return "0";
                sb.append(Integer.toString(i));
            }
        }
        
        answer = sb.toString();
        if(sb.length()==0){
            answer="-1";
        }
        return answer;
    }
}
```

String Builder 미사용시 시간초과