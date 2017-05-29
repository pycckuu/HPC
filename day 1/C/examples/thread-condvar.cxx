#include <iostream>
#include <future>
#include <mutex>
#include <condition_variable>

std::mutex m;
std::condition_variable cv;

bool can_consume = false;
bool can_process = false;
double data;

void func() {
  std::unique_lock<std::mutex> ul(m);
  cv.wait(ul, []{ return can_consume; });

  data *= 2; // lock obtained, process the data
  
  can_process = true;
  ul.unlock();
  cv.notify_one();
}

int main() {
  std::thread t(func);
  data = 4.2;
  { std::lock_guard<std::mutex> lg(m); 
    can_consume = true;
    std::cout << "can_consume!\n";
  }
  cv.notify_one();
  { std::unique_lock<std::mutex> ul(m);
    cv.wait(ul, []{ return can_process; });
    std::cout << "can_process!\n";
  }
  std::cout << "data = " << data << '\n';
  t.join();
}
