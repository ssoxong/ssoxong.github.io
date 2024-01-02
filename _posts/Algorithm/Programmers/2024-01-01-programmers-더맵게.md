---
title: "[프로그래머스][파이썬] 더 맵게"
excerpt: "Programmers 더 맵게"
categories:
    - Programmers
tags:
  - [Programmers, Algorithm]
toc: true
toc_sticky: true

---

# Programmers_Python 더 맵게
https://school.programmers.co.kr/learn/courses/30/lessons/42626


## 문제 설명
매운 것을 좋아하는 Leo는 모든 음식의 스코빌 지수를 K 이상으로 만들고 싶습니다. 모든 음식의 스코빌 지수를 K 이상으로 만들기 위해 Leo는 스코빌 지수가 가장 낮은 두 개의 음식을 아래와 같이 특별한 방법으로 섞어 새로운 음식을 만듭니다.  

```text
섞은 음식의 스코빌 지수 = 가장 맵지 않은 음식의 스코빌 지수 + (두 번째로 맵지 않은 음식의 스코빌 지수 * 2)
```

Leo는 모든 음식의 스코빌 지수가 K 이상이 될 때까지 반복하여 섞습니다.  
Leo가 가진 음식의 스코빌 지수를 담은 배열 scoville과 원하는 스코빌 지수 K가 주어질 때, 모든 음식의 스코빌 지수를 K 이상으로 만들기 위해 섞어야 하는 최소 횟수를 return 하도록 solution 함수를 작성해주세요.

## 문제 풀이

1.heapq를 통해 scoville 배열이 항상 정렬된 형태를 가지도록 한다.  
heapq는 모든 부모 노드가 자식보다 작거나 같은 값을 갖는 이진 트리이기 때문에 작은 스코빌 지수부터 연산하는 문제에 사용하기 적합하다.  

```python
import heapq

heapq.heapify(scoville) # scoville 리스트를 heapq로 변경
```  

2.scoville의 원소 모두 원하는 스코빌 지수 (K)를 넘지 않을 때 **특별한 방법**으로 연산한다.  

```python
#scoville의 원소 모두가 원하는 스코빌 지수를 넘었는지 검사
for s in scoville:
    if s<K:
        break
    elif s==scoville[-1]:
        return answer # 지금까지 연산한 횟수 answer

#모든 음식을 연산하였으나 스코빌 지수가 K를 넘지 못한다면 -1을 리턴
if len(scoville)==1:
    return -1 


#문제에서 제시한 특별한 방법
f = heapq.heappop(scoville)
s = heapq.heappop(scoville)
heapq.heappush(scoville,f+s*2)

answer+=1 # 연산한 횟수 추가
```

3.반복 연산을 위해 2번 방법에 while(True) 추가

## 전체 코드

```python 

import heapq

def solution(scoville, K):
    answer = 0
    heapq.heapify(scoville)

    while(True):
        for s in scoville:
            if s<K:
                break
            elif s==scoville[-1]:
                return answer

        if len(scoville)==1:
            return -1
        
        f = heapq.heappop(scoville)
        s = heapq.heappop(scoville)
        heapq.heappush(scoville,f+s*2)
        
        answer+=1
    return answer
```

## 실행 결과
![image](https://github.com/ssoxong/coding-test/assets/112956015/1dcba631-4c98-4671-8270-35f0ba9e58a4)