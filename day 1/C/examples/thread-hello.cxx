#include <iostream>
#include <random>
#include <chrono>
#include <thread>
#include <vector>
#include <mutex>

std::mutex cout_mutex;

void hello(std::random_device::result_type seed, int i)
{
  { std::lock_guard<std::mutex> guard(cout_mutex);
    std::cout << "Hello " << i << ", id=" << std::this_thread::get_id() << '\n';
  }

  std::default_random_engine dre(seed);
  std::uniform_int_distribution<std::size_t> ud(500, 1000);
  std::this_thread::sleep_for(std::chrono::milliseconds(ud(dre)));

  { std::lock_guard<std::mutex> guard(cout_mutex);
    std::cout << "Bye " << i << ", id=" << std::this_thread::get_id() << '\n';
  }
}

int main()
{
  std::vector<std::thread> v;

  std::random_device rd;
  for (unsigned int i{}; i != std::thread::hardware_concurrency(); ++i)
    v.push_back(std::thread(hello, rd(), i));

  for (auto& e : v)
    e.join();
}
