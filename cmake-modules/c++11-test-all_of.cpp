#include <algorithm>
#include <iostream>

int main() {
  int a[] = { 3, 5, 7, 11, 13 };

  if (std::all_of(a, a+5, [](int i) { return i % 2; })) {
    std::cout << "All elements of a are odd integers..." << std::endl;
  }

  return 0;
}
