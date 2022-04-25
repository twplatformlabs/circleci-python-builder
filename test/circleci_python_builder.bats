#!/usr/bin/env bats

@test "terraform version" {
  run bash -c "docker exec circleci-infra-aws-alpine-edge terraform version"
  [[ "${output}" =~ "1.1.9" ]]
}

@test "tflint version" {
  run bash -c "docker exec circleci-infra-aws-alpine-edge tflint --version"
  [[ "${output}" =~ "0.35.0" ]]
}

@test "curl version" {
  run bash -c "docker exec circleci-infra-aws-alpine-edge curl --version"
  [[ "${output}" =~ "7.80.0" ]]
}

@test "wget version" {
  run bash -c "docker exec circleci-infra-aws-alpine-edge wget --version"
  [[ "${output}" =~ "1.21.2" ]]
}

@test "docker health" {
  run bash -c "docker exec circleci-infra-aws-alpine-edge docker version"
  [[ "${output}" =~ "20.10.14" ]]
}

@test "gpg version" {
  run bash -c "docker exec circleci-infra-aws-alpine-edge gpg --version"
  [[ "${output}" =~ "2.2.31" ]]
}

@test "python3 version" {
  run bash -c "docker exec circleci-infra-aws-alpine-edge python -V"
  [[ "${output}" =~ "3.9" ]]
}

@test "evaluate installed pip packages and versions" {
  run bash -c "docker exec circleci-infra-aws-alpine-edge pip list --format json"
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
  run bash -c "docker exec circleci-infra-aws-alpine-edge bats -v"
  [[ "${output}" =~ "1.6.0" ]]
}
