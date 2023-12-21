---
title: "Programmers - 짝지어 제거하기"
excerpt: "Programmers post"

categories:
    - Algorithm
tags:
  - [Programmers, Algorithm]
toc: true
toc_sticky: true

---
### 짝지어 제거하기

#### code
```java
import java.util.Stack;

class Solution
{
    public int solution(String s)
    {
        Stack<Character> stack = new Stack<>();
        stack.push(s.charAt(0));
        for(int i=1;i<s.length();i++){
            if(stack.size()!=0&&stack.peek()==s.charAt(i))
                stack.pop();
            else
                stack.push(s.charAt(i));
        }
        if(stack.size()==0)
            return 1;
        else
            return 0;
    }
}
```
#### 인터페이스
인터페이스를 상속(implement)하는 class를 위한 규격

인터페이스에서는 변수(필드), 함수(메소드) 선언 가능하지만 구현은 불가능

클래스는 다중상속 불가능(동일 메소드 이슈), 인터페이스는 다중상속 가능

```java
interface Animal {
	(public abstract) void cry(); 
}

 

class Cat implements Animal {

    public void cry() {

        System.out.println("냐옹냐옹!");

    }

}

 

class Dog implements Animal {

    public void cry() {

        System.out.println("멍멍!");

    }

}

 

public class Polymorphism03 {

    public static void main(String[] args) {

        Cat c = new Cat();

        Dog d = new Dog();

 

        c.cry();

        d.cry();

    }

}
```

- 모든 멤버변수는 public static final이어야하며, 이를 생략할 수 있다.—>바꾸지 못하는 값
- 모든 메서드는 public abstract이어야하며, 이를 생략할 수 있다. → 추상메소드!! 구현부가 없어야함

- 클래스에서 클래스 상속받을 때 -> extends
- 인터페이스에서 인터페이스를 상속받을 때 -> extends
- 클래스에서 인터페이스를 상속받을 때 -> implements
- 인터페이스에서 클래스를 상속받을 때 -> (X) 이런경우는 없다.

#### 인터페이스 / 컬렉션 개념 정리
![image](https://github.com/ssoxong/ssoxong.github.io/assets/112956015/977cd429-fbde-4319-8c60-a33ed9148f53)
![image](https://github.com/ssoxong/ssoxong.github.io/assets/112956015/6feb8209-c1f9-49a1-a381-c886cfbcafbf)