# MAKEFILE NOTES
# VAR  = value 	--> (lazy set) Normal setting of a variable - values within it are recursively expanded when the variable is used, not when it's declared
# VAR := value	--> (immediate set) Setting of a variable with simple expansion of the values inside - values within it are expanded at declaration time
# VAR ?= value	--> (if absent) Setting of a variable only if it doesn't have a value
# VAR += value 	--> (append) Appending the supplied value to the existing value (or setting to that value if the variable didn't exist)

# TODO:
#
#



CH:=gcc					# Set the C compiler
CHFLAGS:=-g -Wall			# Set the C compiler flags
CC:=g++					# Set the C++ compiler
CFLAGS:=-g -Wall			# Set the C++ Compiler flags

SRCDIR:=src
BUILDDIR:=build
TARGET:=bin/Drober

SRCEXT:=cpp
SOURCES:=$(shell find $(SRCDIR) -type f -name *.$(SRCEXT))
OBJECTS:=$(patsubst $(SRCDIR)/%,$(BUILDDIR)/%,$(SOURCES:.$(SRCEXT)=.o))
LIB :=
INC := -I include

$(TARGET): $(OBJECTS)
	@echo " Linking..."
	@echo " $(CC) $^ -o $(TARGET) $(LIB)"; $(CC) $^ -o $(TARGET) $(LIB)

$(BUILDDIR)/%.o: $(SRCDIR)/%.$(SRCEXT)
	@mkdir -p $(BUILDDIR)
	@echo " $(CC) $(CFLAGS) $(INC) -c -o $@ $<"; $(CC) $(CFLAGS) $(INC) -c -o $@ $<

clean:
	@echo " Cleaning..."; 
	@echo " $(RM) -r $(BUILDDIR) $(TARGET)"; $(RM) -r $(BUILDDIR) $(TARGET)

# Tests
tester:
	$(CC) $(CFLAGS) test/tester.cpp $(INC) $(LIB) -o bin/testapp

.PHONY: clean
