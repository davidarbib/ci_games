# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: darbib <darbib@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/11/06 14:53:36 by darbib            #+#    #+#              #
#    Updated: 2021/07/26 19:23:42 by darbib           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

BLUE = 		'\033[0;34m'
GREEN = 	'\033[0;32m'
LIGHTBLUE = '\033[1;34m'
RED = 		'\033[0;31m'
YELLOW = 	'\033[1;33m'
ORANGE = 	'\033[0;33m'
MAGENTA = 	'\033[0;35m'
RESET = 	'\033[0m'
CHECK =		'\xE2\x9C\x94'

NAME = ci_games
EXE = $(addprefix ./, $(NAME))
CFLAGS = -std=c++98 -Wall -Wextra -Werror
CC = clang++

ifeq ($(DEBUG), 1)
	CFLAGS += -g3
endif

ifeq ($(SANITIZE), 1)
	CFLAGS += -fsanitize=address
endif

# ------------------------------------------------------------------------------

OBJ_DIR = ./objs/
SRC_DIR = ./srcs/

# ------------------------------------------------------------------------------

OBJ = $(SRC:%.cpp=$(OBJ_DIR)%.o)

INC_DIRS = ./includes

INC = $(addprefix -I, $(INC_DIRS))

SRC = main.cpp \

#TEST_SRC = main_test.cpp
#TEST_FILES_DIR = test_files

# ------------------------------------------------------------------------------

vpath %.cpp $(SRC_DIR)

.PHONY: all clean fclean re test


# ------------------------------------------------------------------------------

all : $(NAME)

$(NAME): $(OBJ)
	@$(CC) $(INC) $(CFLAGS) -o $@ $(OBJ)
	@echo $(GREEN) "binary $@ is successfully built !" $(RESET)

$(OBJ_DIR)%.o : %.cpp
	@mkdir -p objs
	@echo $(BLUE) "compiling" $< $(RESET)
	@$(CC) $(INC) $(CFLAGS) -c $< -o $@ 

clean :
	@echo $(MAGENTA) "Cleaning objs..." $(RESET)
	@rm -rf $(OBJ_DIR)
	@echo $(MAGENTA) "...done" $(RESET)

fclean : clean
	@echo $(MAGENTA) "Total cleaning..."  $(RESET)
	@rm -f $(NAME)
	@echo $(MAGENTA) "...done" $(RESET)

re : fclean all

# ------------------------------------------------------------------------------

test : all
	@echo "test running" > testlog
	@$(EXE)
