#!/bin/bash

margin=.5in
file=PowerRelationships

pandoc -s -V geometry:margin=$margin -o $file.pdf $file.md
