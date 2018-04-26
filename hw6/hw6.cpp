
/*
  C++ solution for the "red-black row blocks" problem

  To compile:   g++ hw6.cpp -o hw6

  To execute:   hw6 n       where n is the # row size  

*/

#include <iostream>
#include <stdlib.h>
#include <stdio.h>
#include <string>
#include <cstring>
#include <sstream>
#include <math.h>
#include <vector>
using namespace std;

void placeRedBlockUnit(int minRedBlockUnitSize, 
                       int redBlockUnitSize, 
                       int rowSize, int start,
                       vector<string>& configurations,
                       std::string prevString);
void placeRedBlocks(int rowSize); 


void placeRedBlockUnit(int minRedBlockUnitSize, 
                       int redBlockUnitSize, 
                       int rowSize, int start,
                       vector<string>& configurations,
                       std::string prevString) 
{
  if (rowSize >= (redBlockUnitSize + start)) 
  {
    // place tile of redBlockUnitSize in position "start" of row
    std::string newConfig(prevString);
    for (int i = 0; i < redBlockUnitSize; i++)
      newConfig[start+i] = 'R';
    configurations.push_back(newConfig);
    // try to place additional R block unit, 
    // leaving one B right after this R block unit
    placeRedBlockUnit(minRedBlockUnitSize, redBlockUnitSize, 
                      rowSize, start+redBlockUnitSize+1, 
                      configurations, newConfig);
    // additionally, try R block units of other sizes
    for (int otherRedBlockUnitSize = minRedBlockUnitSize; 
         otherRedBlockUnitSize <= rowSize;
         otherRedBlockUnitSize++)
      if (otherRedBlockUnitSize != redBlockUnitSize)
        placeRedBlockUnit(minRedBlockUnitSize,
                          otherRedBlockUnitSize, rowSize, 
                          start+redBlockUnitSize+1, 
                          configurations, newConfig);
  }    
}

void placeRedBlocks(int rowSize) 
{
  /*
   Note: Some values for rowSize are infeasible to test
   (e.g., 50 has an expected result of 16475640049, which 
   takes a long time and is likely beyond the capacity of 
   std::vector) 
   Here are some sample results:
   rowSize = 7  configurations.size() = 17
   rowSize = 8  configurations.size() = 26
   rowSize = 9  configurations.size() = 39
   rowSize = 10  configurations.size() = 57
   rowSize = 11  configurations.size() = 82
   rowSize = 12  configurations.size() = 117
  */
  int minRedBlockUnitSize = 3;
  vector<string> configurations;
  std::string allBlack(rowSize,'B');
  // one solution is to have no red block units at all
  configurations.push_back(allBlack);
  for (int i = minRedBlockUnitSize; i <= rowSize; i++)
    for (int start = 0; start < rowSize; start++) 
    {
      placeRedBlockUnit(minRedBlockUnitSize, i, rowSize, start, 
                        configurations, allBlack);
    }
  for (int i = 0; i < configurations.size(); i++)
    cout << configurations[i] << endl;
  cout << "\n# configurations for row size " 
       << rowSize << " is " 
       << configurations.size() << endl;
}

int main(int argc, char** argv) {
  if (argc < 2) {
    printf("You must specify row size in the command line!\n");
    exit(1);
  }
  int N = atoi(argv[1]);
  placeRedBlocks(N);
  return 0;
}
