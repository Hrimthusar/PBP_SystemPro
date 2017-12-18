CC			= gcc
CFLAGS	    = -Wall -Wextra
CCLIBS		= -L/usr/local/mysql-5.7.20-macos10.12-x86_64/lib -lmysqlclient
CLIBPATHS 	= -I/usr/local/mysql-5.7.20-macos10.12-x86_64/include/
PROGRAM		= system_pro

DEPS	=				\
		sql.h			\
		system_pro.h	\

OBJ		=				\
		sql.o			\
		system_pro.o	\

VPATH	= c


.PHONY: all create insert

all: drop create triggers insert $(PROGRAM)

drop:
	mysql -u root --password= -D mysql <sql/drop.sql

create:
	mysql -u root --password= -D mysql <sql/create.sql

triggers:
	mysql -u root --password= -D mysql <sql/triggers.sql

insert:
	mysql -u root --password= -D mysql <sql/insert.sql


%.o: %.c $(DEPS)
	$(CC) $(CLIBPATHS) -c -o $@ $< $(CCFLAGS)

$(PROGRAM): $(OBJ)
	$(CC) $(CLIBPATHS) -o $@ $^ $(CCLIBS) $(CCFLAGS)
