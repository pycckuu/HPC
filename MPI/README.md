### Programming Clusters with Message Passing Interface (MPI)

Description: MPI is a standardized and portable message-passing interface for parallel computing clusters. The standard defines the syntax and semantics of a core of library routines useful to a wide range of scientific programs in C/C++ and Fortran. MPI's goals are high performance, scalability, and portability. It is the dominant parallel programming model used in high-performance-computing today.

In this two-day session, through lectures interspersed with hands-on labs, the students will learn the basics of MPI programming. Examples and exercises will be based on parallelization of common computing problems.

Instructor: Jemmy Hu, SHARCNET, University of Waterloo, Fei Mao, SHARCNET, University of Guelph.

Prerequisites: Basic C/C++ and/or Fortran knowledge; experience editing and compiling code in a Linux environment.

- hardware vs software vs algorithms;
- cpus with shared memory in nodes in networks;
- saw are based on xeon;
- orca on AMD opteron;
- graham (new) - xeon + GPU;
- key 3 parts:
    + login node;
    + storage;
    + network;
- distributed (MPI) vs shared (MP, pthread) memory systems;
- GPU: CUDA, OPenCL, OpenACC;
- MPI, PGAS, UPC, Coarray Fortran;
- OpenMP, pthreads;
- Taks:
    + communication mechanism is significant;
- MPI basics:
    + each CPU is independent;
    + code runs on separate CPU and communicate;
    + each cpu has own memory;
    + you need request data from different cpu (message passing);
    + every communication should be hard coded (difficult);
- what is MPI:
    + mpich 3x;
    + intelmpi 2017;
    + openmpi 2.1;
- reasons to use:
    + standardization;
    + portability;
    + performance;
    + functionality;
    + availability;
- MPI communicator:
    + point-to-point communication: MPI_Send and Recv;
-
