# zed-font-update(Linux)
 Zed 편집기의 설정 파일(settings.json)에 한글 폰트 설정을 자동으로 적용하기 위한 간단한 쉘 스크립트

# 소개
해당 쉘은 Zed 편집기의 설정 파일(settings.json)에 한글 폰트 설정을 자동을 적용하기 위한 간단한 **쉘 스크립트**이며, 막얀 추가적인 기능 사항이 있으면 언제든지 기여를 해도 좋습니다.

# 주요 기능
 * ~/.config/zed/settings.json 파일을 유지
 * "buffer_font_family" 및 "ui_font_family" 값을 "Noto Sans Mono CJK KR"로 추가
 * jq(JSON Parser)를 사용하여 파일 수정
   
# 사용 방법
1. jq 설치
 * fedora
   ```bash
   sudo dnf install jq
   ```
 * Ubuntu/Debian
   ```bash
   sudo apt-get install jq
   ```
2. zed 설치
 * [Zed 공식](https://zed.dev/) 홈페이지나 패키지 관리자를 통해 최신 버전을 설치

# 실행
1. 스크립트 다운로드
2. 실행 권한 부여
3. 스크립트 실행
   * 실행 후, `~/.config/zed/settings.json` 파일 내에 폰트 설정이 자동으로 추가/갱신 됨
   * 만약 `settings.json` 파일이 존재하지 않는다면, 빈 JSON{}파일을 생성한 뒤 설정을 추가함
4. Zed 재시작
   * 이미 Zed를 실행 중이라면 종료 후 다시 시작할 것
   * 이후 Zed 편집기 내에서 코드/텍스트와 UI에 한글 폰트가 적용되어 보임

# 기여 방법
  * 버그 제보나 개선 사항이 있다면, 이슈를 생성하거나 PR(풀 리퀘스트)을 올려주세요.
  * 언제든지 자유롭게 포크(fork)해서 사용하실 수 있습니다.
