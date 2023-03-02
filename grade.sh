CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'
cd student-submission/

# Checks if file exists
if [[ -f ListExamples.java ]]
then 
	mkdir testing-submission

	# Moves the tester file and the student file into the same directory
	cp ListExamples.java ../TestListExamples.java testing-submission
	cd testing-submission
	
	# Copies JUnit files to working directory 
	mkdir lib
	cp ../../lib/hamcrest-core-1.3.jar ../../lib/junit-4.13.2.jar lib	
	
	javac -cp $CPATH *.java 2> erorr-output.txt

	if [[ $? -ne 0 ]] 
	then
		echo "Your file did not compile. D:"
		exit 1	
	fi	


	java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > test-output.txt


	echo "---------------------"
	grep "Tests run:" test-output.txt  > grep.txt
	[ -s grep.txt ]
	if [[ $? -eq 1 ]]
	then 
		echo "100% of tests passed"
	else 	
		cat grep.txt
	fi
else 
	echo "Please submit the correct file."
	exit 1
fi
#rm -r testing-submission
