#include <mysql.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define QUERY_SIZE 2048
#define BUFFER_SIZE 128

enum korisnik {NASTAVNIK, UCENIK, RODITELJ};


void ispisi_nastavnike(MYSQL* connection);
void ispisi_roditelje(MYSQL* connection);
void ispisi_ucenike(MYSQL* connection);

char* uloguj_se(MYSQL* connection, int korisnik);

void dodaj_nastavnika(MYSQL* connection);
void promeni_sifru_nastavniku(MYSQL* connection, char* korisnicko_ime);

void ispisi_rate(MYSQL* connection, char* korisnicko_ime);
void plati_ratu(MYSQL* connection, char* id_rate, char* korisnicko_ime);

void print_result(MYSQL_RES *result);

void error_fatal (char *format, ...);
