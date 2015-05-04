#include <vector>
#include <iostream>

using namespace std;

int main() {
  int a[] = { 1, 2, 3, 4, 5 };
  vector<int> v{ 1, 2, 3, 4, 5 };

  std::cout << "array: ";
  for (int i : a) { std::cout << i << " "; }
  std::cout << "\n";

  std::cout << "vector: ";
  for (int& i : v) { std::cout << i << " "; }
  std::cout << "\n";

  return 0;
}
