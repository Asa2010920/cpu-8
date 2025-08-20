
CC 			 := gcc
CFLAGS   := -O2 -Wall -Wextra -Werror -pedantic -MMD -MP
LDFLAGS  := 

SRC_DIR  := src
OBJ_DIR  := obj
DEP_DIR  := dep

SRCS     := $(wildcard src/.c) 
OBJS     := $(patsubst %.c, $(OBJ_DIR)/*.o, $(SRCS))
DEPS     := $(patsubst %.c, $(DEP_DIR)/*.d, $(SRCS))

TARGET   := cpu8

all: $(TARGET)

run: ./$(TARGET)

push:
	@cp $(TARGET) ~/../usr/bin/

clean:
	@rm -rf $(OBJ_DIR) $(DEP_DIR)
	@mkdir $(OBJ_DIR) $(DEP_DIR)

-include $(DEPS)

$(TARGET): $(OBJS)
	$(CC) $(OBJS) -o $@ $(LDFLAGS)

$(OBJ_DIR)/%.o: %.c
	@mkdir -p $(dir $@) $(DEP_DIR)
	$(CC) $(CFALGS) -c $< -o $@ -MF $(patsubst $(OBJ_DIR)/%.o,$(DEP_DIR)/%.d,$@) 


.PHONY all run clean push
