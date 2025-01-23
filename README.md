## GITLAB 자동 업로드 스크립트

`upload.sh`과 `if-fail.sh`파일에서 `[GITLAB_NAME]`와 `[GITLAB_EMAIL]`을 각자 gitlab 계정으로 수정 후 실행 부탁드립니다.

만약 push에 실패한 경우, failed 리스트를 만들며 `if-fail.sh`을 실행하여 push를 재시도 할 수 있습니다.

`update.sh`은 로컬 git을 업데이트 합니다.