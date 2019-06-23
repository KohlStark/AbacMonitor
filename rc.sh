#!/bin/bash

# This is the Run and Compile script
# It takes all test cases and runs them within your program
# it will then compare the output with the expected output
# It will then tell you what files are the same and what
# are different
# If they are different it will print out the differences
# between the two

# clear the screen
clear

# Build the project
make clean
make all

# Check to see if there is an input directory
# if there is not make the required folder
DIRECTORY="input"
if [ ! -d "$DIRECTORY" ]; then
	echo "ERROR:: You do not have an input directory"
	mkdir input
	echo "NOTE:: One has been made for you"
	echo "NOTE:: Please add all test cases, before running again"
	exit 1
fi

# Check to see if there is an output directory
# if there is not make the needed folders
DIRECTORY="output"
if [ ! -d "$DIRECTORY" ]; then
	echo "ERROR:: You do not have an output directory"
	mkdir output/
	cd output
	mkdir expected/
	mkdir actual/
	cd ../../
	echo "NOTE:: One has been made for you"
	echo "NOTE:: Please add all expected output files before running again"
	exit 1
fi

# removes all old .out files
cd output/actual/
rm -fr *.out
cd ../../

# move to the input directory
cd input/

# for all files that end in .txt
for file in *_f.txt; do


		while IFS='' read -r line || [[ -n "$line" ]]; do

			# save the output
			output="${file}.out"

			# make the file we will output to
			touch $output

    	# execute the assignment using the file as an input
    	# Write all output to the output file we just made
    	../abacmonitor "${line}" > $output

    	# Move the output to the folder with the expected output
    	# to compare it with the expected txt file
    	mv $output ../output/expected/

    	# Change to the correct directory
    	cd ../output/expected/
    	# If the two files are the same
    	if diff -wB "$file.expected" $output; then
        	# Print nothing
        	# If you want to see all the files that are the same
        	# un-comment the line below and comment out: echo "SAME: ..."
        	#echo ""

        	echo "SAME:         ${file}     &       $output"
    	else
        	# Print the names of the files that are different
        	echo "DIFFERENT:    ${file}     &      ${output}"
    	fi

	  done < "$file"

    # Move the output file to the folder of all outputs
    mv $output ../actual/

    # Move back to the input directory
    cd ../../input/
done

cd ../

#grep -rnw ./output/actual/ -e "SYNTAX ERROR"
