# Target path for the compiled binary
TARGET_BIN = ../app/escape_time

# Source file
SRC = escape_time.c

# Compiler and flags
CC = gcc
CFLAGS = -O2 -Wall
# Linker flags (math library)
LDFLAGS = -lm

# Default target
all: $(TARGET_BIN)

$(TARGET_BIN): $(SRC)
	# Linker flags (LDFLAGS) must come *after* the source/object files
	$(CC) $(CFLAGS) -o $(TARGET_BIN) $(SRC) $(LDFLAGS)

clean:
	rm -f $(TARGET_BIN)
