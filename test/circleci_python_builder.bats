#!/usr/bin/env bats

@test "python3 version" {
  run bash -c "docker exec circleci-python-builder-edge python -V"
  [[ "${output}" =~ "3.12" ]]
}

@test "evaluate installed pip packages and versions" {
  run bash -c "docker exec circleci-python-builder-edge pip list --format json"
  [[ "${output}" =~ "{\"name\": \"pip\", \"version\": \"24.1.1\"}" ]]
  [[ "${output}" =~ "{\"name\": \"setuptools\", \"version\": \"70.2.0\"}" ]]
  [[ "${output}" =~ "{\"name\": \"wheel\", \"version\": \"0.43.0\"}" ]]
  [[ "${output}" =~ "{\"name\": \"build\", \"version\": \"1.2.1\"}" ]]
  [[ "${output}" =~ "{\"name\": \"twine\", \"version\": \"5.1.1\"}" ]]
  [[ "${output}" =~ "{\"name\": \"moto\", \"version\": \"5.0.10\"}" ]]
  [[ "${output}" =~ "{\"name\": \"pylint\", \"version\": \"3.2.5\"}" ]]
  [[ "${output}" =~ "{\"name\": \"pytest\", \"version\": \"8.2.2\"}" ]]
  [[ "${output}" =~ "{\"name\": \"pytest-cov\", \"version\": \"5.0.0\"}" ]]
  [[ "${output}" =~ "{\"name\": \"coverage\", \"version\": \"7.5.4\"}" ]]
  [[ "${output}" =~ "{\"name\": \"invoke\", \"version\": \"2.2.0\"}" ]]
  [[ "${output}" =~ "{\"name\": \"requests\", \"version\": \"2.32.3\"}" ]]
  [[ "${output}" =~ "{\"name\": \"Jinja2\", \"version\": \"3.1.4\"}" ]]
}

@test "bats version" {
  run bash -c "docker exec circleci-python-builder-edge bats -v"
  [[ "${output}" =~ "1.11.0" ]]
}

@test "snyk version" {
  run bash -c "docker exec circleci-python-builder-edge snyk version"
  [[ "${output}" =~ "1.1292" ]]
}

@test "cosign version" {
  run bash -c "docker exec circleci-python-builder-edge cosign version"
  [[ "${output}" =~ "2.2" ]]
}

@test "syft version" {
  run bash -c "docker exec circleci-python-builder-edge syft version"
  [[ "${output}" =~ "1.8" ]]
}

@test "oras version" {
  run bash -c "docker exec circleci-python-builder-edge oras version"
  [[ "${output}" =~ "1.2" ]]
}
