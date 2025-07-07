#!/usr/bin/env bats

@test "python3 installed" {
  run bash -c "docker exec circleci-python-builder-edge python --help"
  [[ "${output}" =~ "usage:" ]]
}

@test "evaluate installed pip packages and versions" {
  run bash -c "docker exec circleci-python-builder-edge pip list --format json"
  [[ "${output}" =~ "pip" ]]
  [[ "${output}" =~ "setuptools" ]]
  [[ "${output}" =~ "wheel" ]]
  [[ "${output}" =~ "build" ]]
  [[ "${output}" =~ "twine" ]]
  [[ "${output}" =~ "moto" ]]
  [[ "${output}" =~ "pylint" ]]
  [[ "${output}" =~ "pytest" ]]
  [[ "${output}" =~ "pytest-cov" ]]
  [[ "${output}" =~ "coverage" ]]
  [[ "${output}" =~ "invoke" ]]
  [[ "${output}" =~ "requests" ]]
  [[ "${output}" =~ "Jinja2" ]]
}

@test "bats installed" {
  run bash -c "docker exec circleci-python-builder-edge bats --help"
  [[ "${output}" =~ "Usage: bats" ]]
}

@test "hadolint installed" {
  run bash -c "docker exec circleci-python-builder-edge bats --help"
  [[ "${output}" =~ "Usage: bats" ]]
}

@test "snyk installed" {
  run bash -c "docker exec circleci-python-builder-edge snyk help"
  [[ "${output}" =~ "CLI help" ]]
}

@test "cosign installed" {
  run bash -c "docker exec circleci-python-builder-edge cosign help"
  [[ "${output}" =~ "Usage:" ]]
}

@test "crane installed" {
  run bash -c "docker exec circleci-python-builder-edge crane --help"
  [[ "${output}" =~ "Usage:" ]]
}

@test "syft installed" {
  run bash -c "docker exec circleci-python-builder-edge syft --help"
  [[ "${output}" =~ "Usage:" ]]
}

@test "oras installed" {
  run bash -c "docker exec circleci-python-builder-edge oras --help"
  [[ "${output}" =~ "Usage:" ]]
}
