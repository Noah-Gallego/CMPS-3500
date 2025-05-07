#include <bits/stdc++.h>
using namespace std;
void f(vector<int>& v) {
int n = v.size();for (int i = 0; i < n - 1; i++) {
for (int j = 0; j < n - i - 1; j++) {if (v[j] > v[j + 1])
swap(v[j], v[j + 1]);}}}
int main() {vector<int> a = {5, 1, 4, 2, 8};vector<int> b = {-1, -1, 0, 0, 3, 3, 6};
vector<int> d = {-1, 0, -2121, 1111, 8098, 443222, -123212}; vector<int> w = {600000, 0, -2000000, 100000000, 7000, 40000000};
int input;cout << "chose a list you want to sort:"<< endl;
cout << " 1) List 1"<< endl; cout << " 2) List 2"<< endl;
cout << " 3) List 3"<< endl; cout << " 4) List 4"<< endl; cout << "Please only select one option!" << endl;
; cin >> input;if (input == 1) {
f(a);for (auto i : a) cout << i << " "; cout << endl; return 0;
} else if (input == 2) {
f(b); for (auto i : b) cout << i << " ";
cout << endl; return 0; } else if (input == 3) { f(d); for (auto i : d)
cout << i << " "; cout << endl; 
return 0; } else if (input == 4) {f(w); for (auto i : w) cout << i << " ";
cout << endl; return 0; } else{cout << "Please use a valid input, try again...."<< endl;}
}
