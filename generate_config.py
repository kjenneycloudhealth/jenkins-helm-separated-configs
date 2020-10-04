#!/usr/bin/env python

import glob
import pprint
import hiyapyco

# Script to merge together all YAML files under a path

# Returns a list of names in list files.
print("Using glob.glob()")
files = glob.glob('**/*.yaml', recursive=True)
#pprint.pprint(files)

merged_yaml = hiyapyco.load(files, method=hiyapyco.METHOD_MERGE)
#print(hiyapyco.dump(merged_yaml))

text_file = open("/tmp/jenkins_values.yaml", "w")
n = text_file.write(hiyapyco.dump(merged_yaml))
text_file.close()
