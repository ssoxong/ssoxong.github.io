---
title: "GitBlog - 마크다운 토글 & 코드 입력"
excerpt: "git-blog post"

categories:
    - Blog
tags:
  - [Blog, MarkDown, Github, Git]

toc: true
toc_sticky: true
 
date: 2023-06-01
last_modified_at: 2023-06-01
---

## 마크다운으로 토글 생성하기!!

##### 클릭해보세요
<details>
<summary>토글이란?!</summary>
<div markdowm="1">

이렇게 내용을 숨기는 것입니다~^^

</div>
</details>
<br>

마크다운에서 토글은 지원하지 않아 html 코드로 짜야합니다.

##### code
```html
<details>
<summary>누르기 전</summary>
<div markdowm="1">

누른 후 보일 공간

</div>
</details>
```
이렇게 작성하고 summary 안에 토글 스위치 누르기 전 보여줄 값을 넣어주면 됩니다.
가운데에는 토글 스위치 누르면 보일 값 입력!!

```html
<div markdown="1">
이거는 마크다운에서 html 태그를 읽을 수 있게 하는 값이라고 하네요
```

## 토글 안에 코드 넣기!!
<details>
<summary>토글 안에 코드..?</summary>
<div markdowm="1">

```c++
#include <iostream>

int main(){
    printf("Hello World!");
    return 0;
}
```

</div>
</details>
<br>