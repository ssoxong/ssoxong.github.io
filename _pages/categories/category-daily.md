---
title: "Daily"
layout: archive
permalink: /categories/daily
---


{% assign posts = site.categories.daily %}
{% for post in posts %} {% include archive-single.html type=page.entries_layout %} {% endfor %}