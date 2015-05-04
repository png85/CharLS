#include <algorithm>
#include <iostream>

int main() {
  int a[] = { 3, 5, 7, 9, 11 };
  if (std::none_of(a, a+5, [](int i) { return i < 0; })) {
    std::cout << "a doesn't contain negative numbers" << std::endl;
  }

  return 0;

}
