---
title: "Programmers - 핸드폰 번호 가리기"
excerpt: "Programmers post"

categories:
- Algorithm
tags:
  - [Programmers, Algorithm]
toc: true
toc_sticky: true

---
### 핸드폰 번호 가리기

#### code
```java
public String solution(String phone_number) {

        StringBuilder sb = new StringBuilder();

        for(int i=0;i<(phone_number.substring(0,phone_number.length()-4)).length();i++){
            sb.append("*");
        }

        sb.append(phone_number.substring(phone_number.length()-4,phone_number.length()));
        
        String answer = sb.toString();
        return answer;
    }
```

[https://codingdog.tistory.com/entry/java-string-repeat-메서드로-쉽게-문자열을-반복해-봅시다](https://codingdog.tistory.com/entry/java-string-repeat-%EB%A9%94%EC%84%9C%EB%93%9C%EB%A1%9C-%EC%89%BD%EA%B2%8C-%EB%AC%B8%EC%9E%90%EC%97%B4%EC%9D%84-%EB%B0%98%EB%B3%B5%ED%95%B4-%EB%B4%85%EC%8B%9C%EB%8B%A4)

java 11부터 .repeat() 지원