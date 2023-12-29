---
title: "Programmers - 신규 아이디 추천"
excerpt: "Programmers post"
categories:
    - Programmers
tags:
  - [Programmers, Algorithm]
toc: true
toc_sticky: true

---
### 신규 아이디 추천

#### code
```java
class Solution {
    public String solution(String new_id) {
        String answer = "";

        new_id=new_id.toLowerCase();
				//1단계 new_id의 모든 대문자를 대응되는 소문자로 치환합니다.

        new_id=new_id.replaceAll("[^a-z0-9-_.]",""); 
        //2단계 new_id에서 알파벳 소문자, 숫자, 빼기(-), 밑줄(_), 마침표(.)를 제외한 모든 문자를 제거합니다.

				new_id=new_id.replaceAll("[.]{2,}","."); 
        //3단계 new_id에서 마침표(.)가 2번 이상 연속된 부분을 하나의 마침표(.)로 치환합니다.
        new_id=new_id.replaceAll("^[.]","");
        new_id=new_id.replaceAll("[.]$","");
        //4단계 new_id에서 마침표(.)가 처음이나 끝에 위치한다면 제거합니다.

        if(new_id.length()==0) 
            new_id="a";
        //5단계 new_id가 빈 문자열이라면, new_id에 "a"를 대입합니다.

        if(new_id.length()>15){
            new_id = new_id.substring(0,15);
            new_id=new_id.replaceAll("[.]$","");
        }
				//6단계 new_id의 길이가 16자 이상이면, new_id의 첫 15개의 문자를 제외한 나머지 문자들을 모두 제거합니다. 만약 제거 후 마침표(.)가 new_id의 끝에 위치한다면 끝에 위치한 마침표(.) 문자를 제거합니다.

        if(new_id.length()<=2){
            char last = new_id.charAt(new_id.length()-1);
            while(new_id.length()!=3){
                new_id+=last;
            }
        }
        //7단계 new_id의 길이가 2자 이하라면, new_id의 마지막 문자를 new_id의 길이가 3이 될 때까지 반복해서 끝에 붙입니다.

        answer=new_id;
        return answer;
    }
}
```

#### 정규 표현식

[https://velog.io/@minji/Java-정규표현식String.replaceAll-메서드를-이용한-치환](https://velog.io/@minji/Java-%EC%A0%95%EA%B7%9C%ED%91%9C%ED%98%84%EC%8B%9DString.replaceAll-%EB%A9%94%EC%84%9C%EB%93%9C%EB%A5%BC-%EC%9D%B4%EC%9A%A9%ED%95%9C-%EC%B9%98%ED%99%98)