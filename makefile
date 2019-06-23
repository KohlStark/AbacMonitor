PY=python3
ZIP=abacmonitor_TESTER.zip
MAIN=main
DIR=$(PWD)
.SUFFIXES: .py
FILES = \
	Assignment1.py
All:
	echo " $(PY) $(DIR)/$(FILES) " \"'$$1'\" > abacmonitor
	chmod 777 abacmonitor
