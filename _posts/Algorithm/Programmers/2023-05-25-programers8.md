---
title: "[프로그래머스][자바] 합성수 찾기"
excerpt: "Programmers 합성수 찾기"

categories:
    - Programmers
tags:
  - [Programmers, Algorithm]
toc: true
toc_sticky: true

---
### 합성수 찾기
  
#### 에라토스테네스의 체 이용 → 소수 판별

[https://ko.wikipedia.org/wiki/에라토스테네스의_체](https://ko.wikipedia.org/wiki/%EC%97%90%EB%9D%BC%ED%86%A0%EC%8A%A4%ED%85%8C%EB%84%A4%EC%8A%A4%EC%9D%98_%EC%B2%B4)

#### code
```java
boolean[] prime = new boolean[101]; // 문제 범위 1<=n<=100

Arrays.fill(prime, true); //boolean[] 초기값 false

for(int i = 2; i * i < 101; i++){
    if(!prime[i])
        continue;

    for(int j = 2; i * j < 101; j++){
        prime[i * j] = false;
    }
}
```

→ **O(n log(log n)))**

→ 메모리 많이 먹음