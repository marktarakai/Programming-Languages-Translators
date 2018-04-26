#/bin/bash

# Mark Tarakai
# CS3500: Programming Languages & Translators
# Homework #8: Automated Grading Script -- LISP

# prepare environment for grading routine
rm -rf submissions 
rm -rf expectedOutput 
rm -rf sampleInput
unzip submissions.zip -d submissions
unzip expectedOutput.zip -d expectedOutput
unzip sampleInput.zip -d sampleInput 

# ensure compatibility for all files
for file in $(ls submissions); do
  dos2unix submissions/$file
done

for file in $(ls expectedOutput); do
  dos2unix expectedOutput/$file
done

for file in $(ls sampleInput); do
  dos2unix sampleInput/$file
done

for submission in $(ls submissions); do
  actual_output=$(echo $submission | sed -e "s/\.lisp//")
  num_files=$(ls -1 sampleInput | wc -l)
  correct_files=0
  suspicion=""
  mkdir $actual_output

  for input in $(ls sampleInput); do
    output=$(echo $input | sed -e "s/\.lisp//").out
    gcl -load submissions/$submission -eval "(progn $(cat sampleInput/$input) (quit))" > $actual_output/$output
    diff -w expectedOutput/$output $actual_output/$output &>/dev/null # suppress console output
    if [ $? -eq 0 ]; then
      correct_files=$((correct_files + 1))
      expectedOut=$(cat expectedOutput/$output | sed -e "s/\n//g")
      grep -e $expectedOut submissions/$submission &>/dev/null # suppress console output
      if [ $? -eq 0 ]; then
        suspicion="*"
      fi
    fi
  done

  score=$((correct_files*100/num_files))
  echo "$actual_output, $score$suspicion" >> grades.txt
  # remove output dir
  rm -rf $actual_output
  
done

# cleanse environment
rm -rf submissions 
rm -rf expectedOutput 
rm -rf sampleInput
