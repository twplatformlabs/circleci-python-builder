#!/usr/bin/env bats

@test "curl version" {
  run bash -c "docker exec circleci-python-builder-edge curl --version"
  [[ "${output}" =~ "7.88" ]]
}

@test "wget version" {
  run bash -c "docker exec circleci-python-builder-edge wget --version"
  [[ "${output}" =~ "1.21.3" ]]
}

@test "docker health" {
  run bash -c "docker exec circleci-python-builder-edge docker version"
  [[ "${output}" =~ "20.10.21" ]]
}

@test "gpg version" {
  run bash -c "docker exec circleci-python-builder-edge gpg --version"
  [[ "${output}" =~ "2.2.40" ]]
}

@test "python3 version" {
  run bash -c "docker exec circleci-python-builder-edge python -V"
  [[ "${output}" =~ "3.10" ]]
}

@test "evaluate installed pip packages and versions" {
  run bash -c "docker exec circleci-python-builder-edge pip list --format json"
  [[ "${output}" =~ "{\"name\": \"pip\", \"version\": \"23.0.1\"}" ]]
  [[ "${output}" =~ "{\"name\": \"setuptools\", \"version\": \"67.4.0\"}" ]]
  [[ "${output}" =~ "{\"name\": \"wheel\", \"version\": \"0.38.4\"}" ]]
  [[ "${output}" =~ "{\"name\": \"build\", \"version\": \"0.10.0\"}" ]]
  [[ "${output}" =~ "{\"name\": \"twine\", \"version\": \"4.0.2\"}" ]]
  [[ "${output}" =~ "{\"name\": \"moto\", \"version\": \"4.1.4\"}" ]]
  [[ "${output}" =~ "{\"name\": \"pylint\", \"version\": \"2.16.3\"}" ]]
  [[ "${output}" =~ "{\"name\": \"pytest\", \"version\": \"7.2.2\"}" ]]
  [[ "${output}" =~ "{\"name\": \"pytest-cov\", \"version\": \"4.0.0\"}" ]]
  [[ "${output}" =~ "{\"name\": \"coverage\", \"version\": \"7.2.1\"}" ]]
  [[ "${output}" =~ "{\"name\": \"invoke\", \"version\": \"1.7.3\"}" ]]
  [[ "${output}" =~ "{\"name\": \"requests\", \"version\": \"2.28.2\"}" ]]
  [[ "${output}" =~ "{\"name\": \"Jinja2\", \"version\": \"3.1.2\"}" ]]
}

@test "bats version" {
  run bash -c "docker exec circleci-python-builder-edge bats -v"
  [[ "${output}" =~ "1.9.0" ]]
}

@test "snyk version" {
  run bash -c "docker exec circleci-python-builder-edge snyk version"
  [[ "${output}" =~ "1.1115.0" ]]
}