#include <iostream>
#include <future>
#include <mutex>
#include <condition_variable>

std::atomic<bool> can_consume{false};
std::atomic<bool> can_process{false};
double data;

void func() {
  while (!can_consume.load()) {
    std::this_thread::sleep_for(std::chrono::milliseconds(150));
  }

  data *= 2; // lock obtained, process the data

  can_process.store(true);
}

int main() {
  std::thread t(func);
  data = 4.2;
  can_consume.store(true);
  std::cout << "can_consume!\n";
  while (!can_process.load()) {
    std::this_thread::sleep_for(std::chrono::milliseconds(150));
  }
  std::cout << "can_process!\n";
  std::cout << "data = " << data << '\n';
  t.join();
}
