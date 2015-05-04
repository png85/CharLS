#include <algorithm>
#include <iostream>

int main() {
  int a[] = { -1, 1, 3, 5, -5 };
  if (std::any_of(a, a+5, [](int i) { return i < 0; })) {
    std::cout << "a contains negative numbers" << std::endl;
  }

  return 0;
}
