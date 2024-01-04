---
title: "[프로그래머스][파이썬] 다리를 지나는 트럭"
excerpt: "Programmers 다리를 지나는 트럭"
categories:
    - Programmers
tags:
  - [Programmers, Algorithm, Stack, Queue]
toc: true
toc_sticky: true

---

# Programmers Python 다리를 지나는 트럭
https://school.programmers.co.kr/learn/courses/30/lessons/42583#


## 문제 설명
트럭 여러 대가 강을 가로지르는 일차선 다리를 정해진 순으로 건너려 합니다. 모든 트럭이 다리를 건너려면 최소 몇 초가 걸리는지 알아내야 합니다. 다리에는 트럭이 최대 bridge_length대 올라갈 수 있으며, 다리는 weight 이하까지의 무게를 견딜 수 있습니다. 단, 다리에 완전히 오르지 않은 트럭의 무게는 무시합니다.

예를 들어, 트럭 2대가 올라갈 수 있고 무게를 10kg까지 견디는 다리가 있습니다. 무게가 [7, 4, 5, 6]kg인 트럭이 순서대로 최단 시간 안에 다리를 건너려면 다음과 같이 건너야 합니다.

// 문제 예시 참고

따라서, 모든 트럭이 다리를 지나려면 최소 8초가 걸립니다.

solution 함수의 매개변수로 다리에 올라갈 수 있는 트럭 수 bridge_length, 다리가 견딜 수 있는 무게 weight, 트럭 별 무게 truck_weights가 주어집니다. 이때 모든 트럭이 다리를 건너려면 최소 몇 초가 걸리는지 return 하도록 solution 함수를 완성하세요.

## 문제 풀이
1.bridge 배열을 활용하여 다리를 건너고있는 트럭을 알 수 있도록 하였다. 

```python
bridge = [0 for i in range(bridge_length)]
```  

2.bridge에 올라와있는 트럭의 무게 합이 weight를 넘으면 트럭을 앞으로 하나씩 옮기고 시간을 추가한다.

```python
while(bridge_weight-bridge[0]+truck>weight):
    bridge_weight-=bridge.pop(0)
    answer+=1
    bridge.append(0)
```

3.추가 가능한 경우, 트럭을 추가한다. 

```python
bridge_weight-=bridge.pop(0)
answer+=1
bridge.append(truck)
bridge_weight+=truck
```

4.마지막 트럭의 경우에는 지금까지 시간에 bridge_length를 더한다.

```python
if(index==len(truck_weights)-1):
    answer+=bridge_length
```

# 전체 코드

```python 
def solution(bridge_length, weight, truck_weights):
    answer=0
    bridge = [0 for i in range(bridge_length)]
    bridge_weight = 0
    
    for index, truck in enumerate(truck_weights):
        while(bridge_weight-bridge[0]+truck>weight):
            bridge_weight-=bridge.pop(0)
            answer+=1
            bridge.append(0)

        bridge_weight-=bridge.pop(0)
        answer+=1
        bridge.append(truck)
        bridge_weight+=truck
        
        if(index==len(truck_weights)-1):
            answer+=bridge_length

    return answer
```

# 총 평
- sum 함수 사용시 시간 초과가 발생한다.