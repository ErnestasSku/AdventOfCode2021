#include <cstdio>
#include <iostream>
#include <fstream>
#include <vector>
#include <stack>
#include <map>
#include <algorithm>

using namespace std;

map<char, int> scoreLookUp;

vector<string> readFile(string filename);
void makeScores();
void remakeScores();
void part1(vector<string> &list);
void part2(vector<string>);

int main(int argc, char const *argv[])
{   
    vector<string> list = readFile("input.txt");

    makeScores();
    part1(list);
    remakeScores();
    part2(list);

    return 0;
}

vector<string> readFile(string filename)
{
    ifstream in;
    in.open(filename);

    vector<string> res;
    while(!in.eof())
    {
        string temp;
        in >> temp;
        res.push_back(temp);
    }
    
    return res;
}

auto opening = [](char c) { if (c == '(' || c == '[' || c == '{' || c == '<') return true; else return false; };
auto closing = [](char c) { if (c == ')' || c == ']' || c == '}' || c == '>') return true; else return false; };

void part1(vector<string> &list)
{
    int score = 0;
    for(auto &x : list)
    {
        stack<char> stk;
        for(int i = 0; i < x.length() - 1; i++)
        {
            if(opening(x[i]))
            {
                stk.push(x[i]);
            }
            else if(closing(x[i]))
            {
                char top = stk.top();
                stk.pop();
                //difference between [] {} <> is 2, but difference between () is 1
                int diff = (top == '(') ? 1 : 2;
                if (top != x[i] - diff)
                    {
                        // cout << top << " " << x[i] << "\n";
                        
                        score += scoreLookUp[x[i]];
                        
                        //"remove" the string for part 2
                        x = "";
                        break;
                    }
            }
        }
    }
    cout << score;
}

void part2(vector<string> list)
{
    vector<unsigned long long> All;
    unsigned long long score = 0;
    for(auto &x : list)
    {
        score = 0;
        if (x == "")
            continue;
        stack<char> stk;
        for(int i = 0; i < x.length(); i++)
        {
            if(opening(x[i]))
            {
                stk.push(x[i]);
            }
            else if(closing(x[i]))
            {
                stk.pop();
            }
        }

        while(!stk.empty())
        {
            char top = stk.top();
            int diff = (top == '(') ? 1 : 2;

            score = (score * 5) + scoreLookUp[top + diff];
            stk.pop();
        }

        All.push_back(score);
    }
    cout << "\n";
    sort(All.begin(), All.end());
    cout << "\n" << All[All.size() / 2];
}

void makeScores()
{
    scoreLookUp[')'] = 3; 
    scoreLookUp[']'] = 57; 
    scoreLookUp['}'] = 1197; 
    scoreLookUp['>'] = 25137; 
}

void remakeScores()
{
    scoreLookUp[')'] = 1; 
    scoreLookUp[']'] = 2; 
    scoreLookUp['}'] = 3; 
    scoreLookUp['>'] = 4; 
}
