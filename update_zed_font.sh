#!/usr/bin/env sh

CONFIG_DIR="$HOME/.config/zed"
CONFIG_FILE="$CONFIG_DIR/settings.json"

# .config/zed 디렉터리가 없으면 생성
mkdir -p "$CONFIG_DIR"

# settings.json이 없으면 빈 JSON으로 초기화
if [ ! -f "$CONFIG_FILE" ]; then
  echo "{}" > "$CONFIG_FILE"
fi

# jq를 이용해 buffer_font_family와 ui_font_family를 지정
# 이미 존재한다면 업데이트, 없으면 새로 추가
tmpfile="$(mktemp)"
jq '. + {
  "buffer_font_family": "Noto Sans Mono CJK KR",
  "ui_font_family": "Noto Sans Mono CJK KR"
}' "$CONFIG_FILE" > "$tmpfile" && mv "$tmpfile" "$CONFIG_FILE"

echo "Zed 폰트 설정이 성공적으로 적용되었습니다!"
echo "위치: $CONFIG_FILE"
