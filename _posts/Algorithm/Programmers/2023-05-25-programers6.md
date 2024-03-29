---
title: "[프로그래머스][자바] 이진 변환 반복하기"
excerpt: "Programmers 이진 변환 반복하기"

categories:
    - Programmers
tags:
  - [Programmers, Algorithm]
toc: true
toc_sticky: true

---
### 이진 변환 반복하기
    
```java
class Solution {
    public int[] solution(String s) {
        int[] answer = new int[2];
        
        while(s.length()>1){  
            int one=0;
            for(int i=0;i<s.length();i++){
                if(s.charAt(i)=='0'){
                    answer[1]++;
                }
                else
                    one++;
            
            }
            //s.replace("0","");
            //s = Integer.toBinaryString(s.length());

            s = Integer.toBinaryString(one);
            answer[0]++;
        }
        return answer;
    }
}
```

—> 시간초과

replace()때문..? String replace()이용시 메모리 공간 새로 할당

```java
int i = 127;

//10진수 -> 2, 8, 16
String binaryString = Integer.toBinaryString(i); //2진수
String octalString = Integer.toOctalString(i);   //8진수
String hexString = Integer.toHexString(i);       //16진수

System.out.println(binaryString); //1111111
System.out.println(octalString);  //177
System.out.println(hexString);    //7f

//n진수 -> 10진수
int binaryToDecimal = Integer.parseInt(binaryString, 2);
int octalToDecimal = Integer.parseInt(octalString, 8);
int hexToDecimal = Integer.parseInt(hexString, 16);

System.out.println(binaryToDecimal); //127
System.out.println(octalToDecimal);   //127
System.out.println(hexToDecimal);     //127
```

#### parseInt?

1. static int parseInt(String s) //String to int

```java
String sNum="10";
int iNum = Integer.parseInt(sNum);

sNum -> "10"
iNum -> 10
```

1. static int parseInt(String s, int radix) //radix진수 → 10진수 int형

```java
String sNum="10"; 1*16^1+0*16^0 = 16
int iNum = Integer.parseInt(sNum, 16);

sNum -> "10"
iNum -> 16
```

1. static int parseInt(CharSequence s, int beginIndex, int endIndex, int radix) //주어진 s의 begin 인덱스부터 end-1까지를 radix값으로 보고 → 10진수 int형

```java
CharSequence sNum="12f45";
int iNum = Integer.parseInt(sNum, 1,4,16);
//2f4 -> 2*16^2+f(15)*16+4*16^0 -> 756

iNum -> 16
```

#### CharSequence? 

CharSequence - interface

CharSequence를 상속하는 class로는 String, StringBuffer, StringBuilder… 등이 존재함

https://www.javatpoint.com/java-integer-parseint-method

charsequenc

|

String, StringBuffer, StringBuilder

CharSequence vs String

String - 마크업 문자 입출력 X, 변경 금지 문자

CharSequence - 마크업 문자를 사용하여 변형과 가공 가능

CharSequence 객체의 제공 Method

- char charAt(int index) : 인덱스가 가리키는 문자를 반환한다.
- int length() : CharSequence 객체의 문자수를 반환한다.
- CharSequence subsequence(int start, int end) : start부터 end까지의 문자를 반환한다.
- String toString() : CharSequence 객체를 문자열로 반환한다.

—> http://wawoops67.blogspot.com/2013/01/android-charsequence-string.html