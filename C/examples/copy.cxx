#include <iostream>
#include "output.hxx"
class A {
  public:
    A() { OUT("A() "); }
    A(A const& b) { OUT2("A(copy) ",&b); }
    A& operator =(A const& b) { OUT2("a=b;(copy) ",&b); return *this; }
    ~A() { OUT("~A() "); }
};

int main() { 
  A a; // default constructed
  A b = a; // copy constructed
  a = b; // copy assignment
}
