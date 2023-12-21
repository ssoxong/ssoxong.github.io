---
title: "Programmers - 다음에 올 숫자"
excerpt: "Programmers post"

categories:
    - Algorithm
tags:
  - [Programmers, Algorithm]

toc: true
toc_sticky: true

---

### 다음에 올 숫자
array형 - length

+)

String형 - length()

size()..? → ArrayList<>, Set<>등 컬렉션에 사용

```java
class Solution {
    public int solution(int[] common) {
        int answer = 0;
        if(common[0]-common[1]==common[1]-common[2]){
            return common[common.length-1]+common[2]-common[1];
        }
        else
            return common[common.length-1]*(common[2]/common[1]);
    }
}
```