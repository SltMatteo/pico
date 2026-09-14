CC ?= cc
CFLAGS ?= -Wall -Wextra -pedantic -std=c99
LDFLAGS ?=

TARGET := runpico

.PHONY: all clean

all: $(TARGET)

$(TARGET): pico.c
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $<

clean:
	$(RM) $(TARGET)
