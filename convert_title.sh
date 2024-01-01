#!/bin/bash

# 대상 디렉토리 설정
target_directory="_posts/Study/SP/"

# 대상 파일 패턴 설정 (여기서는 확장자가 .md인 파일들)
file_pattern="*.md"

# 대상 문자열 및 대체 문자열 설정
# search_string="categories:    - .*"
replace_string="- Study"

# 디렉토리로 이동
cd "$target_directory" || exit

# 대상 파일들에 대한 루프 실행
for file in $file_pattern; do
    # sed 명령어를 사용하여 문자열 치환
    # sed -i "s/$search_string/$replace_string/g" "$file"
    awk '/categories:/ {f=1} f && /- SP/ {sub(/- SP/, "'"$replace_string"'"); f=0} 1' "$file" > "$file.tmp" && mv "$file.tmp" "$file"

    # 결과 출력 (선택 사항)
    echo "File $file processed."
done

echo "Conversion complete."
