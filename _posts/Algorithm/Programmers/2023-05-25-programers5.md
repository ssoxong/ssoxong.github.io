---
title: "Programmers - 암호 해독"
excerpt: "Programmers post"

categories:
    - Programmers
tags:
  - [Programmers, Algorithm]
toc: true
toc_sticky: true

---

### 암호해독

code
```java
class Solution {
    public String solution(String[] survey, int[] choices) {
        String answer = "";
        
        StringBuilder sb = new StringBuilder();
        
        String kakao = "RTCFJMAN";
        int[] kakaoNum = new int[8];
        int[] score = {0,3,2,1,0,1,2,3};
        
        for(int i=0;i<survey.length;i++){
            if(choices[i]<4){
                char tmp = survey[i].charAt(0);
                int num = kakao.indexOf(tmp);
                kakaoNum[num]+=score[choices[i]];
            }
            else if(choices[i]>4){
                char tmp = survey[i].charAt(1);
                int num = kakao.indexOf(tmp);
                kakaoNum[num]+=score[choices[i]];
            }
        }
        
        for(int i=0;i<8;i+=2){
            String tmp;
            if(kakaoNum[i]>kakaoNum[i+1]){
                tmp = Character.toString(kakao.charAt(i));
                sb.append(tmp);
            }
            else if(kakaoNum[i]<kakaoNum[i+1]){
                tmp = Character.toString(kakao.charAt(i+1));
                sb.append(tmp);
            }
            else{
                tmp = Character.toString(kakao.charAt(i));
                sb.append(tmp);
            }
            //System.out.println(tmp);

        }
        answer = sb.toString();
        return answer;
    }
}
```
    
String Builder

- append()

```java
StringBuilder sb = new StringBuilder();
sb.append("ab").append("c");
sb.concat("de");

String str = sb.toString();

str//abcde
```

↔ 

String

- concat()

```jsx
String str ="abc";
str.concat("de");

str//abcde
```

<aside>
💡 StringBuilder와 String의 차이점

</aside>