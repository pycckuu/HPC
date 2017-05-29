#include <mutex>
#include <future>
#include <thread>
#include <exception>
#include <stdexcept>
#include <string>
#include <iostream>

std::mutex io_mutex;

void read_data(std::promise<std::string>& p) {
  try {
    char c; std::string retval;
    { std::lock_guard<std::mutex> guard(io_mutex);
      std::cout << "enter char or 'e' for exception: ";
      c = std::cin.get();
    }
    if (std::cin) {
      if (c != 'e') retval += c;
      else throw std::runtime_error(std::string("read_data exception!"));
    }
    retval = std::string("read char ") + c;
    p.set_value(std::move(retval)); // Set promise!
  }
  catch (...) {
    p.set_exception(std::current_exception()); // Set promise!
  }
}

int main() 
{
  try {
    std::promise<std::string> p;
    std::thread t(read_data,std::ref(p));
    t.detach(); // okay since we will wait for the promise below

    std::future<std::string> f(p.get_future()); // Ask for future value/exception
    std::cout << "result: " << f.get() << '\n'; // Retrieve future value/exception
  }
  catch (const std::exception& e) {
    std::cerr << "EXCEPTION: " << e.what() << '\n';
  }
  catch (...) {
    std::cerr << "EXCEPTION\n";
  }
}
