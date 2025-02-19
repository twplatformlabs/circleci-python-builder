#!/usr/bin/env bats

@test "python3 version" {
  run bash -c "docker exec circleci-python-builder-edge python -V"
  [[ "${output}" =~ "3.12" ]]
}

@test "evaluate installed pip packages and versions" {
  run bash -c "docker exec circleci-python-builder-edge pip list --format json"
  [[ "${output}" =~ "{\"name\": \"pip\", \"version\": \"25.0.1\"}" ]]
  [[ "${output}" =~ "{\"name\": \"setuptools\", \"version\": \"75.8.0\"}" ]]
  [[ "${output}" =~ "{\"name\": \"wheel\", \"version\": \"0.45.1\"}" ]]
  [[ "${output}" =~ "{\"name\": \"build\", \"version\": \"1.2.1\"}" ]]
  [[ "${output}" =~ "{\"name\": \"twine\", \"version\": \"6.1.0\"}" ]]
  [[ "${output}" =~ "{\"name\": \"moto\", \"version\": \"5.0.28\"}" ]]
  [[ "${output}" =~ "{\"name\": \"pylint\", \"version\": \"3.3.4\"}" ]]
  [[ "${output}" =~ "{\"name\": \"pytest\", \"version\": \"8.3.4\"}" ]]
  [[ "${output}" =~ "{\"name\": \"pytest-cov\", \"version\": \"6.0.0\"}" ]]
  [[ "${output}" =~ "{\"name\": \"coverage\", \"version\": \"7.6.12\"}" ]]
  [[ "${output}" =~ "{\"name\": \"invoke\", \"version\": \"2.2.0\"}" ]]
  [[ "${output}" =~ "{\"name\": \"requests\", \"version\": \"2.32.3\"}" ]]
  [[ "${output}" =~ "{\"name\": \"Jinja2\", \"version\": \"3.1.5\"}" ]]
}

@test "bats version" {
  run bash -c "docker exec circleci-python-builder-edge bats -v"
  [[ "${output}" =~ "1.11" ]]
}

@test "snyk version" {
  run bash -c "docker exec circleci-python-builder-edge snyk version"
  [[ "${output}" =~ "1.1295" ]]
}

@test "cosign version" {
  run bash -c "docker exec circleci-python-builder-edge cosign version"
  [[ "${output}" =~ "2.4" ]]
}

@test "crane version" {
  run bash -c "docker exec circleci-python-builder-edge crane version"
  [[ "${output}" =~ "0.20" ]]
}

@test "syft version" {
  run bash -c "docker exec circleci-python-builder-edge syft version"
  [[ "${output}" =~ "1.19" ]]
}

@test "oras version" {
  run bash -c "docker exec circleci-python-builder-edge oras version"
  [[ "${output}" =~ "1.2" ]]
}
