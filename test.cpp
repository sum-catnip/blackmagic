#include <stdlib.h>

class Test {
public:
  int salad;
  char poop;
  bool pee;
};

struct Test2 {
public:
  int salad;
  char poop;
  bool pee;
};

enum Test3 { salad, poop, pee };

void peepee(Test t1, Test2 t2) {
  auto x = t1.pee;
  int y = t2.salad;
  auto top = "salad";
  auto kek = 'a';
}
