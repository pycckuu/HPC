#include <iostream>
#include <thread>
#include <future>

double func(double a, double b) {
  return a + b;
}

int main() 
{
  std::future<double> fut = std::async(func,1.1,2.2); 
  std::cout << fut.get() << '\n'; // get the result
}
