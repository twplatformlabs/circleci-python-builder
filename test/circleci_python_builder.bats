#!/usr/bin/env bats

@test "curl version" {
  run bash -c "docker exec circleci-python-builder-edge curl --version"
  [[ "${output}" =~ "7.80.0" ]]
}

@test "wget version" {
  run bash -c "docker exec circleci-python-builder-edge wget --version"
  [[ "${output}" =~ "1.21.2" ]]
}

@test "docker health" {
  run bash -c "docker exec circleci-python-builder-edge docker version"
  [[ "${output}" =~ "20.10.14" ]]
}

@test "gpg version" {
  run bash -c "docker exec circleci-python-builder-edge gpg --version"
  [[ "${output}" =~ "2.2.31" ]]
}

@test "python3 version" {
  run bash -c "docker exec circleci-python-builder-edge python -V"
  [[ "${output}" =~ "3.9" ]]
}

@test "evaluate installed pip packages and versions" {
  run bash -c "docker exec circleci-python-builder-edge pip list --format json"
  [[ "${output}" =~ "{\"name\": \"pip\", \"version\": \"22.0.4\"}" ]]
  [[ "${output}" =~ "{\"name\": \"setuptools\", \"version\": \"62.1.0\"}" ]]
  [[ "${output}" =~ "{\"name\": \"wheel\", \"version\": \"0.37.1\"}" ]]
  [[ "${output}" =~ "{\"name\": \"pylint\", \"version\": \"2.13.7\"}" ]]
  [[ "${output}" =~ "{\"name\": \"pytest\", \"version\": \"7.1.2\"}" ]]
  [[ "${output}" =~ "{\"name\": \"coverage\", \"version\": \"6.3.2\"}" ]]
  [[ "${output}" =~ "{\"name\": \"invoke\", \"version\": \"1.7.0\"}" ]]
  [[ "${output}" =~ "{\"name\": \"requests\", \"version\": \"2.27.1\"}" ]]
  [[ "${output}" =~ "{\"name\": \"jinja2\", \"version\": \"3.1.1\"}" ]]
}

@test "bats version" {
  run bash -c "docker exec circleci-python-builder-edge bats -v"
  [[ "${output}" =~ "1.6.0" ]]
}
