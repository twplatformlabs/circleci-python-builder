#!/usr/bin/env bats

@test "docker health" {
  run bash -c "docker exec circleci-python-builder-edge docker version"
  [[ "${output}" =~ "23.0" ]]
}

@test "python3 version" {
  run bash -c "docker exec circleci-python-builder-edge python -V"
  [[ "${output}" =~ "3.11" ]]
}

@test "evaluate installed pip packages and versions" {
  run bash -c "docker exec circleci-python-builder-edge pip list --format json"
  [[ "${output}" =~ "{\"name\": \"pip\", \"version\": \"23.1.2\"}" ]]
  [[ "${output}" =~ "{\"name\": \"setuptools\", \"version\": \"68.0.0\"}" ]]
  [[ "${output}" =~ "{\"name\": \"wheel\", \"version\": \"0.40.0\"}" ]]
  [[ "${output}" =~ "{\"name\": \"build\", \"version\": \"0.10.0\"}" ]]
  [[ "${output}" =~ "{\"name\": \"twine\", \"version\": \"4.0.2\"}" ]]
  [[ "${output}" =~ "{\"name\": \"moto\", \"version\": \"4.1.11\"}" ]]
  [[ "${output}" =~ "{\"name\": \"pylint\", \"version\": \"2.17.4\"}" ]]
  [[ "${output}" =~ "{\"name\": \"pytest\", \"version\": \"7.4.0\"}" ]]
  [[ "${output}" =~ "{\"name\": \"pytest-cov\", \"version\": \"4.1.0\"}" ]]
  [[ "${output}" =~ "{\"name\": \"coverage\", \"version\": \"7.2.7\"}" ]]
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
  [[ "${output}" =~ "1.1184.0" ]]
}
