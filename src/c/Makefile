CC=gcc
CFLAGS=-Wall -I/usr/local/mysql-5.7.20-macos10.12-x86_64/include/ -L/usr/local/mysql-5.7.20-macos10.12-x86_64/lib -lmysqlclient

demo: system_pro.c system_pro.h
	$(CC) $(CFLAGS) system_pro.c -o system_pro
