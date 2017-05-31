-include ./Makefile.inc

OBJS = lenna.o
PROG = lenna

default: lenna
all: lenna

%.o: %.f90
	$(FC) $(FFLAGS) -c -o $@ $<

lenna: $(OBJS)
	$(FC) -o $(PROG) $(OBJS) $(LDFLAGS)

clean:
	rm -f *.o *.mod core* *.pgm
