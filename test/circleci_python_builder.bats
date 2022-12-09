#!/usr/bin/env bats

@test "curl version" {
  run bash -c "docker exec circleci-python-builder-edge curl --version"
  [[ "${output}" =~ "7.86.0" ]]
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
  [[ "${output}" =~ "{\"name\": \"pip\", \"version\": \"22.3.1\"}" ]]
  [[ "${output}" =~ "{\"name\": \"setuptools\", \"version\": \"65.6.3\"}" ]]
  [[ "${output}" =~ "{\"name\": \"wheel\", \"version\": \"0.38.4\"}" ]]
  [[ "${output}" =~ "{\"name\": \"pylint\", \"version\": \"2.15.8\"}" ]]
  [[ "${output}" =~ "{\"name\": \"pytest\", \"version\": \"7.2.0\"}" ]]
  [[ "${output}" =~ "{\"name\": \"coverage\", \"version\": \"6.5.0\"}" ]]
  [[ "${output}" =~ "{\"name\": \"invoke\", \"version\": \"1.7.3\"}" ]]
  [[ "${output}" =~ "{\"name\": \"requests\", \"version\": \"2.28.1\"}" ]]
  [[ "${output}" =~ "{\"name\": \"Jinja2\", \"version\": \"3.1.3\"}" ]]
}

@test "bats version" {
  run bash -c "docker exec circleci-python-builder-edge bats -v"
  [[ "${output}" =~ "1.8.2" ]]
}
