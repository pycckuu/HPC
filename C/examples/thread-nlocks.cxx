#include <iostream>
#include <thread>
#include <mutex>
#include <algorithm>

struct entity {
  std::mutex m_; // for locking
  double d;      // data
};

void swap_entities(entity& a, entity& b) {
  std::lock(a.m_, b.m_); // Acquire both locks
  std::lock_guard<std::mutex> lga(a.m_, std::adopt_lock);
  std::lock_guard<std::mutex> lgb(b.m_, std::adopt_lock);
  std::swap(a.d, b.d); // do processing
}

int main() {
  entity a, b, c; a.d = 1.1; b.d = 2.2; c.d = 3.3;
  std::thread t1(swap_entities, std::ref(a), std::ref(b));
  std::thread t2(swap_entities, std::ref(a), std::ref(c));
  t1.join(); t2.join();
  std::cout << a.d << ' ' << b.d << ' ' << c.d << '\n';
}
