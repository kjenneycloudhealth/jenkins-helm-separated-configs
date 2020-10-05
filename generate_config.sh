#!/usr/bin/env bash

## Script to merge together all YAML files under a path

# Get a list of all YAML files to merge
files=$(find config -type f -name "*.yaml")
echo $files

# Merge them
yq m -a=append $files > /tmp/jenkins_values.yaml
