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

![image](https://github.com/ssoxong/ssoxong.github.io/assets/112956015/f81e28ac-8351-4261-999f-249716b09eb9)

이미지처럼 마크다운 문법으로 코드를 넣으니까 이상하게 보인다.

### 왜?
아마 html 코드 안에 markdown 문법을 써서 그렇다고 추측..

## 토글 안에 코드 넣기 (최종)
https://colorscripter.com/
여기에 코드를 복사해 넣은 뒤, 하단의 html로 복사 클릭

<details>
<summary>토글 안에 코드 넣기 (최종)</summary>
<div markdowm="1">

<div class="colorscripter-code" style="color:#f0f0f0;font-family:Consolas, 'Liberation Mono', Menlo, Courier, monospace !important; position:relative !important;overflow:auto"><table class="colorscripter-code-table" style="margin:0;padding:0;border:none;background-color:#272727;border-radius:4px;" cellspacing="0" cellpadding="0"><tr><td style="padding:6px;border-right:2px solid #4f4f4f"><div style="margin:0;padding:0;word-break:normal;text-align:right;color:#aaa;font-family:Consolas, 'Liberation Mono', Menlo, Courier, monospace !important;line-height:130%"><div style="line-height:130%">1</div><div style="line-height:130%">2</div><div style="line-height:130%">3</div><div style="line-height:130%">4</div><div style="line-height:130%">5</div><div style="line-height:130%">6</div></div></td><td style="padding:6px 0;text-align:left"><div style="margin:0;padding:0;color:#f0f0f0;font-family:Consolas, 'Liberation Mono', Menlo, Courier, monospace !important;line-height:130%"><div style="padding:0 6px; white-space:pre; line-height:130%"><span style="color:#0086b3">#include</span>&nbsp;<span style="color:#aaffaa"></span><span style="color:#ff3399">&lt;</span>iostream<span style="color:#aaffaa"></span><span style="color:#ff3399">&gt;</span></div><div style="padding:0 6px; white-space:pre; line-height:130%">&nbsp;</div><div style="padding:0 6px; white-space:pre; line-height:130%"><span style="color:#4be6fa">int</span>&nbsp;main(){</div><div style="padding:0 6px; white-space:pre; line-height:130%">&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:#4be6fa">printf</span>(<span style="color:#ffd500">"Hello&nbsp;World!"</span>);</div><div style="padding:0 6px; white-space:pre; line-height:130%">&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:#ff3399">return</span>&nbsp;<span style="color:#c10aff">0</span>;</div><div style="padding:0 6px; white-space:pre; line-height:130%">}</div></div></td><td style="vertical-align:bottom;padding:0 2px 4px 0"><a href="http://colorscripter.com/info#e" target="_blank" style="text-decoration:none;color:white"><span style="font-size:9px;word-break:normal;background-color:#4f4f4f;color:white;border-radius:10px;padding:1px">cs</span></a></td></tr></table></div>

</div>
</details>
<br>

이렇게 예쁘게 넣어지는 것을 알 수 있습니다~!
꼭 토글만이 아니더라도 블로그 쓸 때 예쁘게 코드 넣기 좋겠네요.