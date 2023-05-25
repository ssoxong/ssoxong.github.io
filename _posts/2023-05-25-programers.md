---
title: "Programmers - 개인정보 수집 유효기간"
excerpt: "Programmers post"

categories:
    - Programmers
tags:
  - [Programmers, Algorithm]

toc: true
toc_sticky: true

---
### 개인정보 수집 유효기간
    
String to int

- Integer.parseInt(String s)

int to String

- Integer.toString(int i)

str.substring(int start, int end) //String 파싱

ex) 

```jsx
String str="Hello World!";
String str2 = str.substring(0,4);
System.out.println(str2);

//Hell
```

str.contains()

문자열  안에 해당 값이 있는지 알려줌 → boolean형

```jsx
String str = "my java test";

System.out.println( str.contains("java") );  // true
System.out.println( str.contains("    my") );  // false
System.out.println( str.contains("JAVA") );  // false
System.out.println( str.contains("java test") );  // true
```

str.indexOf()

문자열 안에 해당 값이 있으면 그 문자열의 시작 index 리턴, 없을시 -1

#### code

```java
class Solution {
    public int[] solution(String today, String[] terms, String[] privacies) {
        int[] answer = {};
        int[] tmpans = new int[privacies.length];
        int index=0;
        int cnt=0;
        
        int todayint=Integer.parseInt(today.substring(0,4)+today.substring(5,7)+today.substring(8,10));

        
        int[] deadline =  new int[privacies.length];
        
        for(int i=0;i<privacies.length;i++){
            
            String typestr = privacies[i].substring(11);
            int type=0;
            for(int j=0;j<terms.length;j++){
                if(terms[j].contains(typestr)){
                    type=j;
                    break;
                }
            }
            
            String collect = privacies[i].substring(0,10);
            
            int year=Integer.parseInt(collect.substring(0,4));
            int month=Integer.parseInt(collect.substring(5,7));
            int day=Integer.parseInt(collect.substring(8,10));
            
            int due = Integer.parseInt(terms[type].substring(2));
            
            day--;
            if(day<1){
                month--;
                day=28;
            }
            
            if(due>12){
                year+=due/12;
                due%=12;
            }
            month+=due;
            if(month>12){
                year++;
                month-=12;
            }
           
            String y=Integer.toString(year);
            String m="";
            if(month<10)
                m="0";
            m+=Integer.toString(month);
            String d="";
            if(day<10)
                d="0";           
            d+=Integer.toString(day);
            
            deadline[i]=Integer.parseInt(y+m+d);
            System.out.println(i+" "+deadline[i]);
            if(todayint>deadline[i]){
                tmpans[index++]=i+1;
                cnt++;
            }
        }
        answer = new int[cnt];
        index=0;
        for(int i=0;i<tmpans.length;i++){
            if(tmpans[i]!=0){
                answer[index++]=tmpans[i];
            }
        }
        return answer;
    }
}
```
