#!/usr/bin/env bats

setup() {
  if [[ -z "${TEST_CONTAINER}" ]]; then
    echo "ERROR: TEST_CONTAINER environment variable is not set"
    echo "Example:"
    echo "  TEST_CONTAINER=my-container bats tests.bats"
    exit 1
  fi
}

@test "python3 installed" {
  run bash -c "docker exec ${TEST_CONTAINER} python --help"
  [[ "${output}" =~ "usage:" ]]
}

@test "evaluate installed pip packages and versions" {
  run bash -c "docker exec ${TEST_CONTAINER} pip list --format json"
  [[ "${output}" =~ "pip" ]]
  [[ "${output}" =~ "setuptools" ]]
  [[ "${output}" =~ "wheel" ]]
  [[ "${output}" =~ "build" ]]
  [[ "${output}" =~ "twine" ]]
  [[ "${output}" =~ "moto" ]]
  [[ "${output}" =~ "pylint" ]]
  [[ "${output}" =~ "pytest" ]]
  [[ "${output}" =~ "pytest-cov" ]]
  [[ "${output}" =~ "pytest-asyncio" ]]
  [[ "${output}" =~ "pytest-env" ]]
  [[ "${output}" =~ "coverage" ]]
  [[ "${output}" =~ "invoke" ]]
  [[ "${output}" =~ "requests" ]]
  [[ "${output}" =~ "mock" ]]
  [[ "${output}" =~ "bandit" ]]
  [[ "${output}" =~ "black" ]]
  [[ "${output}" =~ "Jinja2" ]]
}

@test "bats installed" {
  run bash -c "docker exec ${TEST_CONTAINER} bats --help"
  [[ "${output}" =~ "Usage: bats" ]]
}

@test "hadolint installed" {
  run bash -c "docker exec ${TEST_CONTAINER} bats --help"
  [[ "${output}" =~ "Usage: bats" ]]
}

@test "snyk installed" {
  run bash -c "docker exec ${TEST_CONTAINER} snyk help"
  [[ "${output}" =~ "CLI help" ]]
}

@test "cosign installed" {
  run bash -c "docker exec ${TEST_CONTAINER} cosign help"
  [[ "${output}" =~ "Usage:" ]]
}

@test "crane installed" {
  run bash -c "docker exec ${TEST_CONTAINER} crane --help"
  [[ "${output}" =~ "Usage:" ]]
}

@test "syft installed" {
  run bash -c "docker exec ${TEST_CONTAINER} syft --help"
  [[ "${output}" =~ "Usage:" ]]
}

@test "trivy installed" {
  run bash -c "docker exec ${TEST_CONTAINER} trivy --help"
  [[ "${output}" =~ "Usage:" ]]
}

@test "oras installed" {
  run bash -c "docker exec ${TEST_CONTAINER} oras --help"
  [[ "${output}" =~ "Usage:" ]]
}
