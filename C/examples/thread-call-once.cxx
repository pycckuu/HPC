#include <iostream>
#include <thread>
#include <mutex>

std::once_flag one_time;
std::mutex cout_mutex;

void msg(const char* str) {
  std::lock_guard<std::mutex> guard(cout_mutex);
  std::cout << std::this_thread::get_id() << ": " << str << '\n';
}

void do_only_once() {
  std::call_once(one_time, [](){ msg("Do this only once!"); });
  msg("Do this multiple times.");
}

int main() {
  std::thread t1(do_only_once), t2(do_only_once), t3(do_only_once);
  t1.join(); t2.join(); t3.join();
}
