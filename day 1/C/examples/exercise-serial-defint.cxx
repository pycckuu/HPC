#include <cmath>
#include <limits>
#include <iostream>
#include <iomanip>

using UInt = unsigned int;
using Real = double;

template <typename Op>
Real definite_integral(Real a, Real b, UInt n, Op op)
{
  Real width = b - a;                 // Width of the entire interval
  Real delta_x = width / n;           // Width of each subdivision's rectangle
  Real sum = 0.0;                     // Start the sum at 0.
  for (UInt i=0; i<n; ++i)            // Iterate from [0,n)
  {
    Real x = a + (i+0.5) * delta_x;   // Compute the midpoint of current rectangle
    Real area = delta_x * op(x);      // Apply op(x)
    sum += area;                      // And accumulate the area.
  }
  return sum;
}

int main()
{
  using namespace std;

  Real pi = 
    definite_integral(
      0.0, 1.0, 100000000, 
      [](Real x) -> Real { return 1.0 / (1.0 + x*x); }
    ) * 4;

  // Ensure numbers are not written in scientific notation...
  cout.unsetf(ios_base::floatfield);
  cout.setf(ios_base::fixed, ios_base::floatfield);

  cout
    << "pi = "
    << setw(numeric_limits<Real>::max_digits10) 
    << setprecision(numeric_limits<Real>::max_digits10) 
    << pi
    << " (error = "
    << setw(numeric_limits<Real>::max_digits10) 
    << setprecision(numeric_limits<Real>::max_digits10) 
    << abs(pi - 3.14159265358979323846264338)
    << ")\n"
  ;
}
