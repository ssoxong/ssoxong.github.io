---
title: "[프로그래머스][파이썬] 이중우선순위큐"
excerpt: "Programmers 이중우선순위큐"
categories:
    - Programmers
tags:
  - [Programmers, Algorithm, Heap]
toc: true
toc_sticky: true

---

# Programmers Python 이중우선순위큐
https://school.programmers.co.kr/learn/courses/30/lessons/42628?language=python3


## 문제 설명
이중 우선순위 큐는 다음 연산을 할 수 있는 자료구조를 말합니다.

|명령어|수신 탑(높이)|
|---|---|
|I 숫자|큐에 주어진 숫자를 삽입합니다.|
|D 1|큐에서 최댓값을 삭제합니다.|
|D -1|큐에서 최솟값을 삭제합니다.|

이중 우선순위 큐가 할 연산 operations가 매개변수로 주어질 때, 모든 연산을 처리한 후 큐가 비어있으면 [0,0] 비어있지 않으면 [최댓값, 최솟값]을 return 하도록 solution 함수를 구현해주세요.

- 제한사항  
operations는 길이가 1 이상 1,000,000 이하인 문자열 배열입니다.
operations의 원소는 큐가 수행할 연산을 나타냅니다.
원소는 “명령어 데이터” 형식으로 주어집니다.- 최댓값/최솟값을 삭제하는 연산에서 최댓값/최솟값이 둘 이상인 경우, 하나만 삭제합니다.
빈 큐에 데이터를 삭제하라는 연산이 주어질 경우, 해당 연산은 무시합니다.

## 문제 풀이

1.for 구문으로 operations을 탐색하며 명령어에 따라 케이스를 나눈다.

```python
for o in operations:
    if o.startswith('I'):
        tmp = o.split(" ") //숫자와 명령어 나누기
        ...
    elif o=="D 1":
        ...
    elif o=="D -1":
        ...
```  

2.최솟값, 최댓값을 알기 위해 두 개의 heapq를 생성한다.  
heapq는 최솟값만 지원하기 때문에 숫자 부호를 바꿔서 삽입할 maxArr도 필요하다.

```python
import heapq

minArr=[]
maxArr=[]

heapq.heapify(minArr)
heapq.heapify(maxArr)
``` 

3.Insert 명령시, 두개의 힙에 값을 push한다.  
```python
 if o.startswith('I'):
    tmp = o.split(" ")
    
    heapq.heappush(minArr, int(tmp[1]))
    heapq.heappush(maxArr, -int(tmp[1])) // 부호 반대로 삽입
```

4.Delete 명령시, 값을 처리한다.
```python
elif o=="D 1" and maxArr:
    heapq.heappop(maxArr)
                    
elif o=="D -1" and minArr:
    heapq.heappop(minArr)
```
5.minArr, maxArr의 교집합을 구하여 결과적으로 최솟값, 최댓값이 사라진 리스트를 만든다.

```python
answer = set(minArr)&set([-x for x in maxArr])
```

maxArr의 부호를 반대로 해줘야 교집합이 정상적으로 작동한다. 

5.그 후 minArr, maxArr를 재할당 해주고 나머지 리턴 연산을 처리한다.

# 전체 코드

```python 
import heapq

def solution(operations):
    answer = set([])
    minArr= []
    maxArr= []
    
    for oper in operations:        
        heapq.heapify(minArr)
        heapq.heapify(maxArr)
        
        if oper.startswith('I'):
            tmp = oper.split(" ")
            
            heapq.heappush(minArr, int(tmp[1]))
            heapq.heappush(maxArr, -int(tmp[1]))
            
        elif oper=="D 1" and maxArr:
            heapq.heappop(maxArr)
                           
        elif oper=="D -1" and minArr:
            heapq.heappop(minArr)
        
        answer = set(minArr)&set([-x for x in maxArr])

        minArr=list(set(minArr)&answer)
        maxArr=list(set(maxArr)&set([-x for x in answer]))
        
        
    print(answer)
    if(len(answer)==0):
        return [0,0]
    
    return [max(answer), min(answer)]
```

# 실행 결과

![image](https://github.com/GAE4COON/.github/assets/112956015/91871ca0-4b82-4dff-93cb-f5d45246f340)



# 총 평
이게되네? 싶은 코드..