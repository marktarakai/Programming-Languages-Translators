#/bin/bash
unzip submissions.zip -d submissions
for file in $(ls submissions); do
  dos2unix submissions/$file
done

for file in $(ls submissions); do
	submission_file=$(echo $file | sed 's/[a-z]*[0-9]*_//g')
	submission_file=$(echo $submission_file | sed 's/-//g')
	submission_file=$(echo $submission_file | sed 's/[0-9]*//g')
	mv submissions/$file submissions/$submission_file
	g++ submissions/$submission_file -o a
	student_name=$(basename submissions/$submission_file .cpp)
	./a 4 >> $student_name.txt.out
	if grep -x "24" $student_name.txt.out; then echo "$student_name, 100" >> grades.txt
	else
		echo "$student_name, 0" >> grades.txt
	fi
done