#include <iostream>
#include <thread>
#include <future>

double func(double a, double b) {
  return a + b;
}

int main() 
{
  std::packaged_task< double(double, double) > task(func);
  std::future<double> fut = task.get_future(); // get the future
  // ... later ...
  task(1.1, 2.2); // invoke the task
  // ... later ...
  std::cout << fut.get() << '\n'; // get the result
}
