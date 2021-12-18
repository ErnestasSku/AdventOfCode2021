//Day 4 solution for Aoc. (A little bit messy solution)

#include <cstdio>
#include <fstream>
#include <cstring>
#include <vector>
#include <iostream>
#include <algorithm>

using namespace std;

#define maxArray 100000

void readFile(string filename);
void part1();
void part2();

vector<int> line;
int tableCount = 0;
vector<int> table[1000];

int main()
{
    readFile("input.txt");
    //part1();
    part2();
    return 0;
}

void readFile(string filename)
{
    ifstream in;
    in.open(filename);
    
   
    while(true)
    {
        int temp;
        char tempChar;
        in >> temp >> tempChar;
        line.push_back(temp);
        if (tempChar != ',')
            {
                in.putback(tempChar);
                break;
            }
    }
   
   while(!in.eof())
   {
       for(int i = 0; i < 25; i++)
       {
           int temp;
           in >> temp;
           table[tableCount].push_back(temp);
       }
       tableCount++;
   }

}

void removeNumber(int number)
{
    for(int i = 0; i < tableCount; i++)
    {
        for(int j = 0; j < 25; j++)
        {
            if(table[i][j] == number)
                table[i][j] = -1;
        }
    }
}

bool debug = true;

bool checkBoard(vector<int> board)
{
    for(int i = 0; i < 5; i++)
    {
        bool victory = true;
        for(int j = 0; j < 5; j++)
        {
            if(board[5 * i + j] != -1)
                victory = false;
        }
        if(victory)
            return true;
    }

    for(int i = 0; i < 5; i++)
    {
        bool victory = true;
        for(int j = 0; j < 5; j++)
        {
            if(board[i + 5 * j] != -1)
                victory = false;
        }
        if(victory)
            return true;
    }
    debug = false;
    return false;
}

int checkVictory()
{
    for(int i = 0; i < tableCount; i++)
    {
        if(checkBoard(table[i]))
            {
                return i;
            }
    }
    return -1;
}

void calculateScore(int index, int multiplier)
{
    int sum = 0;
    for(int i = 0; i < table[index].size(); i++)
    {
        if(table[index][i] != -1)
            sum += table[index][i]; 
    }
    cout << "\n" << sum << " " << multiplier << "\n" << sum * multiplier;
}

void part1()
{
    for(int i = 0; i < line.size(); i++)
    {
        removeNumber(line[i]);
        int a = checkVictory();
        if(a != -1)
            {
                calculateScore(a, line[i]);
                break;
            }
    }
}

void removeBoard(int index)
{
    for(auto &em : table[index])
        em = -2;
}

void part2()
{
    vector<int> victories;
    vector<int> lastBoard;
    int lastMultiplier;
    int board = 0;
    for(int i = 0; i < line.size(); i++)
    {
        removeNumber(line[i]);
        
        int a = 0; 
        do 
        {
            a = checkVictory();
            if(a != -1)
                {
                    if(find(victories.begin(), victories.end(), a) == victories.end())
                        {
                            lastBoard.clear();
                            for(auto &em : table[a])
                                {
                                    lastBoard.push_back(em);
                                }
                            //cout << " adding " << a << "\n";
                            victories.push_back(a);
                            lastMultiplier = line[i];
                        }
                    removeBoard(a);
                }
        }while( a != -1);
    }

    table[victories[victories.size() - 1]] = lastBoard;

    calculateScore(victories[victories.size() - 1], lastMultiplier);
}