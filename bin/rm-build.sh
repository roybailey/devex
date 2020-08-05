#!/bin/bash
find . -name target -depth -exec rm -rf {} \;
find . -name node_modules -depth -exec rm -rf {} \;
find . -name build -depth -exec rm -rf {} \;
