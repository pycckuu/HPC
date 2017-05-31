-include ./Makefile.inc

OBJS = heat_p.o
PROG = heat_p

default: heat_p
all: heat_p

%.o: %.f90
	$(FC) $(FFLAGS) -c -o $@ $<

heat_p: $(OBJS)
	$(FC) -o $(PROG) $(OBJS) $(LDFLAGS)

clean:
	rm -f *.o *.mod output*.dat core*
