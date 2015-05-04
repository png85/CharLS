#include <memory>

using namespace std;

int main(void) {
  unique_ptr<int> p1(new int);
  unique_ptr<int[]> p2(new int[10]);

  return 0;
}
