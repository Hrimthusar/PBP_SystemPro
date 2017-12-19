#include <mysql.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define QUERY_SIZE 2048
#define BUFFER_SIZE 128

#define WAIT 1
#define DONT_WAIT 0

enum korisnik {NASTAVNIK, UCENIK, RODITELJ};

char* uloguj_se(MYSQL* connection, int korisnik);

// administracija
void ispisi_nastavnike(MYSQL* connection, int wait);
void ispisi_roditelje(MYSQL* connection);
void ispisi_ucenike(MYSQL* connection, int wait);
void promeni_grupu(MYSQL* connection);

// nastavnik
void dodaj_nastavnika(MYSQL* connection);
void promeni_sifru_nastavniku(MYSQL* connection, char* korisnicko_ime);

// roditelj
void ispisi_rate(MYSQL* connection, char* korisnicko_ime, int wait);
void ispisi_placeno(MYSQL* connection, char* korisnicko_ime);
void plati_ratu(MYSQL* connection, char* id_rate, char* korisnicko_ime);

// uceniku
void ispisi_projekte(MYSQL* connection, char* korisnicko_ime);
void ispisi_solobodne_projekte(MYSQL* connection, char* korisnicko_ime);
void radi_na_projektu(MYSQL* connection, char* id_projekta, char* korisnicko_ime);

void print_result(MYSQL_RES *result, int wait);
void error_fatal (char *format, ...);
