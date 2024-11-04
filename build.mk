CC = gcc
CFLAGS = -Iinclude -MMD
LD = gcc
LFLAGS = 

SRC = $(shell find src -type f -name "*.c")
OBJ = $(SRC:src/%.c=build/obj/%.o)
DEP = $(OBJ:%.o=%.d)
LIB = $(addprefix -l, )

EXE = a.out

default: debug
	@$(ECHO) Build complete

debug: CFLAGS += -Wall -Wextra -g -Og -fsanitize=address
debug: LFLAGS += -fsanitize=address
release: CFLAGS += O3
release: LFLAGS +=

debug release: build/$(EXE)

-include $(DEP)

build:
	@$(ECHO) Creating folder $@
	@mkdir -p $@
build/obj: | build
	@$(ECHO) Creating folder $@
	@mkdir -p $@

build/obj/%.o: src/%.c | build/obj
	@$(ECHO) Compiling $<
	@$(CC) -c $< $(CFLAGS) -o $@

build/$(EXE): $(OBJ) | build
	@$(ECHO) Linking $@
	@$(LD) $^ $(LFLAGS) $(LIB) -o $@

clean:
	@rm -rf build
	@$(ECHO) Clean complete

.PHONY: default debug release clean
