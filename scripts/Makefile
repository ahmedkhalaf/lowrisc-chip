base_dir = $(abspath ..)

CXXSRCS := comlog float_fix
CXXFLAGS := $(CXXFLAGS) -std=c++11 -Wall

OBJS := $(addsuffix .o,$(CXXSRCS))
PROGRAMS := $(CXXSRCS)

all: $(PROGRAMS)

%: %.o
	$(CXX) $< $(LDFLAGS) -o $@

%.o: $(base_dir)/csrc/%.cc
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	rm -f $(OBJS) $(PROGRAMS)

LIB= /home/jrrk2/.opam/4.02.3/lib

cnvjson: cnvjson.ml
	ocamlopt -o $@ -I $(LIB)/yojson $(LIB)/biniou/biniou.cmxa $(LIB)/easy-format/easy_format.cmxa $(LIB)/yojson/yojson.cmxa cnvjson.ml
