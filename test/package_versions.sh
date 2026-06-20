#!/usr/bin/env bats

if [[ -z "${TEST_CONTAINER}" ]]; then
  echo "ERROR: TEST_CONTAINER environment variable is not set"
  exit 1
fi

bash -c "docker exec ${TEST_CONTAINER} python -V"
bash -c "docker exec ${TEST_CONTAINER} pip list"
bash -c "docker exec ${TEST_CONTAINER} bats --version"
RESULT=$(bash -c "docker exec ${TEST_CONTAINER} snyk version")
echo "snyk ${RESULT}"
bash -c "docker exec ${TEST_CONTAINER} hadolint --version" && echo
RESULT=$(bash -c "docker exec ${TEST_CONTAINER} cosign version | grep GitVersion")
echo "cosign ${RESULT}" && echo
bash -c "docker exec ${TEST_CONTAINER} syft --version" && echo
RESULT=$(bash -c "docker exec ${TEST_CONTAINER} oras version | head -n 1")
echo "oras ${RESULT}" && echo
bash -c "docker exec ${TEST_CONTAINER} crane --version" && echo
RESULT=$(bash -c "docker exec ${TEST_CONTAINER} trivy --version | grep Version")
echo "trivy ${RESULT}" && echo
RESULT=$(bash -c "docker exec ${TEST_CONTAINER} docker scout version | grep version")
echo "Scout ${RESULT}" && echo
