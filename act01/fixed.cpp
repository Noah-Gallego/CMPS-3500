/****************************************************/
/* NAME: Noah Gallego */
/* ASGT: Activity 1 */
/* ORGN: CSUB - CMPS 3500 */
/* FILE: fixed.cpp */
/* DATE: 01/31/2025 */
/****************************************************/

#include <bits/stdc++.h> // For Vectors; easy implementation
using namespace std;

// Print the Vector 
void printVector(vector<int> &v) {
    string str = "{";
    for(int i = 0; i < v.size(); i++) {    
        str += (i != v.size() - 1) ? (to_string(v[i]) + ", ") : (to_string(v[i]) + "}");
    }
    cout << "Vector: " << str << endl;
}

// Bubble Sort a given Vector
void bubbleSort(vector<int> &v) {
    int n = v.size();
    for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < n - i - 1; j++) {
            if (v[j] > v[j + 1]) swap(v[j], v[j + 1]);
        }
    }

    printVector(v);
}

int main() {
    vector<vector<int>> vector_list = {
        {5, 1, 4, 2, 8},
        {-1, -1, 0, 0, 3, 3, 6},
        {-1, 0, -2121, 1111, 8098, 443222, -123212},
        {600000, 0, -2000000, 100000000, 7000, 40000000}
    };

    // Display Menu
    int list_choice;
    cout << "Choose a list you want to sort:\n" << endl;
    for (int i = 0; i < 4; i++) {
        cout << i + 1 << ") ";
        printVector(vector_list[i]);
    }

    // Get User Choice
    cout << "Please only select one option!\n\nList Number: ";
    cin >> list_choice;

    // Process input
    if (list_choice >= 1 && list_choice <= vector_list.size())
        bubbleSort(vector_list[list_choice - 1]);
    else
        cout << "Please use a valid input, try again...." << endl;

    return 0;
}