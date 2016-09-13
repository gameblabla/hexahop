PRGNAME     = hexahop

# define regarding OS, which compiler to use
CC          = gcc
CCP         = g++
LD          = gcc

DATADIR = "./data"

# change compilation / linking flag options
F_OPTS		= -Isrc  -DRELATIVE_PATHS
CC_OPTS		= -O2 -fomit-frame-pointer -fdata-sections -ffunction-sections $(F_OPTS)
CFLAGS		= $(shell sdl-config --cflags) $(CC_OPTS)
CXXFLAGS	=$(CFLAGS) 
LDFLAGS     = -lSDLmain -lSDL -lm -flto -lSDL_mixer -lmikmod -lSDL_ttf -lstdc++

# Files to be compiled
SRCDIR    = ./src
VPATH     = $(SRCDIR)
SRC_C   = $(foreach dir, $(SRCDIR), $(wildcard $(dir)/*.c))
SRC_CP   = $(foreach dir, $(SRCDIR), $(wildcard $(dir)/*.cpp))
OBJ_C   = $(notdir $(patsubst %.c, %.o, $(SRC_C)))
OBJ_CP   = $(notdir $(patsubst %.cpp, %.o, $(SRC_CP)))
OBJS     = $(OBJ_C) $(OBJ_CP)

# Rules to make executable
$(PRGNAME): $(OBJS)  
	$(LD) $(CFLAGS) -o $(PRGNAME) $^ $(LDFLAGS)

$(OBJ_C) : %.o : %.c
	$(CC) $(CFLAGS) -c -o $@ $<

$(OBJ_CP) : %.o : %.cpp
	$(CCP) $(CXXFLAGS) -c -o $@ $<

clean:
	rm -f $(PRGNAME) *.o
