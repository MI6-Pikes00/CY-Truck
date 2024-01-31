# defines compiler
CC = gcc

#Repository
SRC_DIR := progc

# defines executable name 
EXEC_NAME = option 

# get all c files
SRC=$(wildcard $(SRC_DIR)/*.c) # progc/main.c

# build the executable
exec: $(SRC)
	$(CC) $^ -o $(EXEC_NAME)