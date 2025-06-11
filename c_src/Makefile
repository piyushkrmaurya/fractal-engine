# Target path for the compiled binary
TARGET_BIN = ../app/escape_time

# Source file
SRC = escape_time.c

# Compiler and flags
CC = gcc
# -O2 for optimization, -Wall for warnings, -lm to link the math library
CFLAGS = -O2 -Wall -lm

# Default target
all: $(TARGET_BIN)

$(TARGET_BIN): $(SRC)
	$(CC) $(CFLAGS) -o $(TARGET_BIN) $(SRC)

clean:
	rm -f $(TARGET_BIN)






























