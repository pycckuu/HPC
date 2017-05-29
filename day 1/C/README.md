### C++ for High Performance Computing

There was no defined memory model for concurrency in C or C++ prior to the ISO 2011 C and C++ standards. This means that any code exploiting concurrency relies on implementation and undefined behaviour for the specific compiler and hardware used. This makes it extremely difficult to determine if a program is correct and renders code non-portable. Having a memory model enables one to determine whether or not a program is correct and makes it easier to write portable code.

The 2011 C++ standard introduced into C++ support for concurrency, e.g., support for memory models, threads, mutexes, locks, condition variables, and atomics. The C++ memory model is concerned with how structures are laid out in memory, and, how memory locations can be used concurrently to produce well-defined computational results, e.g., by avoiding data races. The latter is supported, at the lowest level, by atomic stores, loads, and read-modify-write operations; and understanding the synchronizes-with and happens-before relationships.

This class will focus on:

understanding move semantics, how moving is implemented, and when to use std::move and std::forward,
understanding some of the important lower-level aspects (e.g., atomics, synchronizes-with, happens-before), and,
how to make use of higher-level C++ constructs such as promises, futures, threads, locks, and condition variables.
Instructor: Paul Preney, SHARCNET, University of Windsor.

Prerequisites: The attendee is expected to know how to write procedural and object-oriented C++ code (C++98 or newer). If familiarity with C++ is weak, the attendee is expected to have intermediate to advanced experience writing (i) object-oriented code, (ii) concurrent code that exploits multithreading (e.g., Java, C/C++ with Pthreads, and/or OpenMP), and, before the class, (iii) review std::vector, std::array, as well as learn how to write and use a C++ class including at least the default and copy constructors; destructor; and copy assignment operator.

Account: lab03
password: 8mdD5n-03

### Notes:

- OpenCL: heterogenious computing;
- C/C++ concurrency should be in sync as opposed to C++11;
- concurrency in C++:
    + was introduced in c11;
    + use at least C++11 compiler: memory model is well defined (exploit with atomics);
        * access to variables and changes in threads;
    + issues not only with compiler but with hardware too;
- c98 supports copy semantics/default constructor;
- "new" is for dynamic memory;
- destructor called when out of scoped in C++;
- moving with pointer is a way faster than copying;
- copying (std::copy) A->B:
    + create temp variable T;
    + copy all A in T;
    + if no exception then "swap(B,T)";
    + Destroy T
- Copy and Move elision (c/c11):
    + copy elision by the compiler -> zero overhead (no additional costs);
    + it can be performed by compiler in return statements;
    + in temporary classes;
- compiler  must assign memory address for pointer but reference not;
- write print statements with output of the address;
- once you inside {} in the constructor the object is fully contracted;
- && is reference not reference to reference (standard does not allow that);
- lvalue - has a user defined name;
- rvalue - doesnt have user defined value like int(5);
- xvlues (expiring value) - values that will be destroed by compiler after function call;
- std::move transfers the ownership (whos owns it);
    + to move objects around for threads before multitasking;
- "const" tells the compiler that it is read-only object and can be very optimized;
- use libraries: Eigen or Boost;
- std::forward - it checks if can be moved it will be moved and if not then copied;
- "..." c11 any amount of args in function call;


### using concurrency constructs:

- use std lib: vec, arrays etc;
- -login nodes vs development nodes:
    + 1 hour CPU time on login;
