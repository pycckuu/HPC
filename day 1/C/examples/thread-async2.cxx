#include <iostream>
#include <random>
#include <chrono>
#include <thread>
#include <future>

void slow(std::random_device::result_type seed) {
  std::default_random_engine dre(seed);
  std::uniform_int_distribution<std::size_t> ud(500,1000);
  std::this_thread::sleep_for(std::chrono::milliseconds(ud(dre)));
  return;
}

int func1(std::random_device::result_type seed, int i) {
  slow(seed);
  return i*2;
}

double func2(std::random_device::result_type seed, int i) {
  slow(seed);
  return i*3.2;
}

int main() 
{
  std::random_device rd;
  std::future<int> one = std::async(std::launch::async,func1,rd(),1);
  std::future<double> two = std::async(std::launch::async,func2,rd(),2);
  std::cout << one.get() << ',' << two.get() << '\n'; 
}
