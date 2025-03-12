# Docker 기반 CI 워크플로우

이 저장소는 Docker 컨테이너를 사용하여 여러 Linux 배포판에서 자동화된 테스트를 수행하는 GitHub Actions 워크플로우를 포함하고 있습니다.

## 워크플로우 기능

### 멀티 환경 테스트
워크플로우는 매트릭스 전략을 사용하여 여러 Linux 배포판에서 코드를 테스트합니다:
- Fedora 37
- Debian Stable
- Ubuntu 22.04

이를 통해 다양한 Linux 환경과 패키지 관리 시스템 간의 호환성을 보장합니다.

### 자동화된 트리거 설정
워크플로우는 다음 상황에서 자동으로 실행됩니다:
- `main` 브랜치에 푸시할 때
- `develop` 브랜치에 푸시할 때
- `feature/*` 패턴과 일치하는 브랜치에 푸시할 때
- `release/*` 패턴과 일치하는 브랜치에 푸시할 때
- `main` 또는 `develop` 브랜치로 PR을 생성할 때
- 매주 일요일 자정에 예약 실행 (cron: '0 0 * * 0')

### 컨테이너화된 테스트
각 배포판별로 격리된 Docker 컨테이너에서 테스트가 실행되어 다음과 같은 이점을 제공합니다:
- 깨끗하고 재현 가능한 테스트 환경
- 테스트 환경 간의 완벽한 격리
- 더 신뢰할 수 있는 테스트를 위한, 실제 운영 환경과 유사한 환경

### 성능 최적화
- Docker Buildx 설정을 통한 빌드 성능 향상
- Docker 레이어 캐싱을 통한 빌드 속도 개선
- `fail-fast: false` 설정으로 하나의 테스트가 실패해도 다른 테스트는 계속 진행

### 동적 환경 감지
워크플로우는 Linux 배포판을 자동으로 감지하고 적절한 패키지 관리자를 사용합니다:
- Fedora 기반 시스템을 위한 DNF
- Debian/Ubuntu 기반 시스템을 위한 APT

### 코드 정적 분석
워크플로우는 쉘 스크립트와 Python 코드에 대한 정적 분석을 포함합니다:
- `shellcheck`를 사용하여 쉘 스크립트 문법 검증 및 잠재적 문제 식별
- `pylint`를 사용하여 Python 코드의 정적 분석 수행

### 자동 테스트 감지 및 실행
워크플로우는 프로젝트 구조에 따라 적절한 테스트 방법을 자동으로 선택합니다:
- Makefile의 test 타겟 사용
- tests/run_tests.sh 스크립트 실행
- pytest를 사용한 Python 테스트 실행

### 보안 스캔
- Trivy 취약점 스캐너를 사용하여 코드베이스의 보안 취약점 식별
- SARIF 형식으로 보안 스캔 결과 저장 및 업로드

### 알림 시스템
- 테스트 실패 시 Slack을 통한 자동 알림
- 테스트 결과를 GitHub 아티팩트로 저장하여 나중에 분석할 수 있도록 함

## 워크플로우 구성

워크플로우는 `.github/workflows/docker-ci.yml`에 정의되어 있습니다:

```yaml
name: Enhanced CI with Docker
on:
  push:
    branches: [ "main", "develop", "feature/*", "release/*" ]
  pull_request:
    branches: [ "main", "develop" ]
  schedule:
    - cron: '0 0 * * 0'  # 매주 일요일 자정에 실행

jobs:
  build-and-test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        distro: [ fedora:37, debian:stable, ubuntu:22.04 ]
      fail-fast: false  # 하나의 테스트가 실패해도 다른 테스트는 계속 진행
    
    steps:
      # 워크플로우 단계 생략...
```

## 사용 방법

이 워크플로우는 코드가 푸시되거나 PR이 생성될 때 자동으로 실행되지만, 수동으로도 실행할 수 있습니다:

1. GitHub 저장소의 "Actions" 탭으로 이동
2. "Enhanced CI with Docker" 워크플로우 선택
3. "Run workflow" 버튼 클릭
4. 실행할 브랜치 선택
5. "Run workflow" 버튼을 클릭하여 테스트 시작

## 워크플로우 확장 방법

이 워크플로우는 다음과 같은 방법으로 확장할 수 있습니다:

1. 매트릭스에 더 많은 Linux 배포판 추가
2. 컨테이너에 추가 테스트 도구 설치
3. 코드 정적 분석 후 더 많은 테스트 명령 추가
4. 테스트 결과를 나중에 분석할 수 있도록 아티팩트 생성
5. 추가적인 보안 스캔 도구 통합
6. 다른 알림 채널(이메일, 메신저 등) 추가

## 문제 해결

워크플로우가 실패할 경우:

1. GitHub Actions 탭에서 로그를 확인하여 실패한 단계 식별
2. 쉘 스크립트가 로컬에서 shellcheck 검증을 통과하는지 확인
3. 코드가 테스트 중인 모든 Linux 배포판과 호환되는지 확인
4. 로그에서 Docker 관련 문제 확인
5. 보안 스캔 단계에서 권한 문제가 발생한 경우 리포지토리 설정 확인
