CC = g++
LDFLAGS =
LDTESTFLAGS = -lcriterion 
CFLAGS = -O  
ifeq ($(DEBUG),1)
	CFLAGS += -g3
endif
ifdef DYNAMIC_STACK_INITIAL_CAPACITY
	CFLAGS += -DDYNAMIC_STACK_INITIAL_CAPACITY=$(DYNAMIC_STACK_INITIAL_CAPACITY)
endif
ifdef FIXED_ARRAY_STACK_CAPACITY
	CFLAGS += -DFIXED_ARRAY_STACK_CAPACITY=$(FIXED_ARRAY_STACK_CAPACITY)
endif

MAINS = $(shell find src/mains/ -maxdepth 1 -type f -name "*.cpp")
SRCS = $(shell find src/ -maxdepth 1 -type f -name "*.cpp")
MAINOBJS = $(patsubst src/mains/%.cpp, obj/mains/%.o, $(MAINS))
MAINOUTS = $(patsubst src/mains/%.cpp, %, $(MAINS))
TESTS = $(shell find src/tests/ -maxdepth 1 -type f -name "*.cpp")
TESTOBJS = $(patsubst src/tests/%.cpp, obj/tests/%.o, $(TESTS))
TESTOUTS = $(patsubst src/tests/%.cpp, %, $(TESTS))
OBJS = $(patsubst src/%.cpp, obj/%.o, $(SRCS))

all: $(MAINOUTS)

$(MAINOUTS): $(OBJS) $(MAINOBJS)
	@mkdir -p bin
	$(CC) $(CFLAGS) -o bin/$@ obj/mains/$@.o $(OBJS) $(LDFLAGS)

$(TESTOUTS): $(OBJS) $(TESTOBJS)
	@mkdir -p bin
	$(CC) $(CFLAGS) -o bin/$@ obj/tests/$@.o $(OBJS) $(LDTESTFLAGS) -DRUNNING_TESTS

obj/%.o: src/%.cpp 
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) -c $< -o $@

obj/mains/%.o: src/mains/%.cpp 
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) -c $< -o $@

obj/tests/%.o: src/tests/%.cpp 
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) -c $< -o $@

.PHONY: test clean

test: $(TESTOUTS)
	 for file in $^ ; do \
		 bin/$${file} ; \
	 done

clean:
	rm -rf bin/ 
	rm -rf obj/
