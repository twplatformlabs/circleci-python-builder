#!/usr/bin/env bats

@test "python3 installed" {
  run bash -c "docker exec container-test python --help"
  [[ "${output}" =~ "usage:" ]]
}

@test "evaluate installed pip packages and versions" {
  run bash -c "docker exec container-test pip list --format json"
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
  run bash -c "docker exec container-test bats --help"
  [[ "${output}" =~ "Usage: bats" ]]
}

@test "hadolint installed" {
  run bash -c "docker exec container-test bats --help"
  [[ "${output}" =~ "Usage: bats" ]]
}

@test "snyk installed" {
  run bash -c "docker exec container-test snyk help"
  [[ "${output}" =~ "CLI help" ]]
}

@test "cosign installed" {
  run bash -c "docker exec container-test cosign help"
  [[ "${output}" =~ "Usage:" ]]
}

@test "crane installed" {
  run bash -c "docker exec container-test crane --help"
  [[ "${output}" =~ "Usage:" ]]
}

@test "syft installed" {
  run bash -c "docker exec container-test syft --help"
  [[ "${output}" =~ "Usage:" ]]
}

@test "oras installed" {
  run bash -c "docker exec container-test oras --help"
  [[ "${output}" =~ "Usage:" ]]
}
