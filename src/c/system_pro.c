#include "system_pro.h"

#define QUERY_SIZE 2048
#define BUFFER_SIZE 128

static void error_fatal (char *format, ...);

void ispisi(MYSQL *connection);

void ispisi_nastavinke(MYSQL *connection);
void dodaj_nastavnika(MYSQL *connection);
void promeni_sifru_nastavniku(MYSQL *connection);

void print_result(MYSQL_RES *result);

int main (int argc, char **argv)
{
    MYSQL *connection;
    connection = mysql_init (NULL);
    if (connection == NULL){
      error_fatal ("Greska u konekciji. %s\n", mysql_error (connection));
    }

    if (mysql_real_connect(connection, "127.0.0.1", "root", NULL, "system_pro",
        0, NULL,0) == NULL){
        error_fatal ("Greska u konekciji. %s\n", mysql_error (connection));
    }
    char option[2];
    int running = 1;
    system("clear");

    while(running){
        printf("\n/--------------------------------\\\n");
        printf("| Skola programiranja SYSTEM PRO |\n");
        printf("\\--------------------------------/\n\n");
        printf("- \e[4mI\e[24mspis\n"); // Registruj _nastavinka
        printf("- Registruj \e[4mn\e[24mastavnika\n"); // Registruj _nastavinka
        printf("- Promeni \e[4ms\e[24mifru nastavniku\n"); // Registruj _nastavinka
        printf("- Nova \e[4mg\e[24mrupa\n"); // Nova _grupa
        printf("- \e[4mK\e[24mraj\n"); // _Kraj

        printf("Unesite podvuceni karakter: ");
        scanf("%s", option);
        printf("\n");

        switch (option[0]) {
            case 'i':
            case 'I':
                ispisi(connection);
                break;
            case 'n':
            case 'N':
                ispisi_nastavinke(connection);
                dodaj_nastavnika(connection);
                ispisi_nastavinke(connection);
                break;
            case 's':
            case 'S':
                promeni_sifru_nastavniku(connection);
                break;
            case 'k':
            case 'K':
                running = 0;
                break;
            case '\n':
                break;
            default:
                system("clear");
                printf("Pogresan ulaz\n");
                break;
        }
    }
    mysql_close (connection);
    exit(EXIT_SUCCESS);
}

void ispisi(MYSQL *connection){
    char option[2];
    system("clear");
    printf("\nISPISI\n");
    printf("- \e[4mN\e[24mastavnike\n"); // Nastavnike
    printf("- \e[4mU\e[24mcenike\n"); // Ucenike
    printf("- \e[4mR\e[24moditelje\n"); // Roditelje

    printf("Unesite podvuceni karakter: ");
    scanf("%s", option);
    printf("\n");

    switch (option[0]) {
        case 'n':
        case 'N':
            ispisi_nastavinke(connection);
            break;
        case 'u':
        case 'U':
            break;
        case 'r':
        case 'R':
            break;
        case '\n':
            break;
        default:
            system("clear");
            printf("Pogresan ulaz\n");
            break;
    }
}

void print_result(MYSQL_RES *result)
{
    MYSQL_FIELD *field;
    MYSQL_ROW row;

    int sifra_pos = -1;
    for(int i = 0; NULL != (field = mysql_fetch_field(result)); i++){
        if(!strcmp(field->name, "sifra")){
            sifra_pos = i;
            printf("%-33s| ", field->name);
        } else {
            printf("%-15s| ", field->name);
        }
    }
    printf("\n");
    int num_fields = mysql_num_fields(result);

    while ((row = mysql_fetch_row(result)) ){
        for (int i=0; i<num_fields; i++){
            if(i == sifra_pos)
                printf ("%-33s| ", row[i] ? row[i] : "NULL");
            else
                printf ("%-15s| ", row[i] ? row[i] : "NULL");
        }
        printf ("\n");
    }

    printf ("\n");
}

void promeni_sifru_nastavniku(MYSQL *connection)
{
    MYSQL_RES *result;
    MYSQL_ROW row;

    char query[QUERY_SIZE];

    char korisnicko_ime[BUFFER_SIZE];
    char sifra[BUFFER_SIZE];
    printf("Ulogujte se...\n");
    printf("Korisnicko ime: ");
    scanf("%s", korisnicko_ime);
    printf("Sifra: ");
    scanf("%s", sifra);

    sprintf (query, "select * from nastavnik where korisnicko_ime = '%s' and sifra = MD5('%s')",
                                                   korisnicko_ime, sifra);

    if (mysql_query (connection, query) != 0){
        error_fatal ("Greska u upitu %s\n", mysql_error (connection));
    }
    result = mysql_use_result (connection);

    row = mysql_fetch_row(result);
    if (row == 0){
        printf("Pogresno korisnicko ime ili sifra\n");
        return;
    }

    printf("Izaberite novu sifru\n");
    scanf("%s", sifra);
    mysql_free_result (result);

    sprintf(query, "update Nastavnik set sifra = '%s' where korisnicko_ime = '%s'",
                                         sifra, korisnicko_ime);

    if (mysql_query (connection, query) != 0){
        error_fatal ("Greska u upitu %s\n", mysql_error (connection));
    }

    if (mysql_affected_rows(connection) == 0){
        printf("Sifra nije uspesno promenjena.\n");
    } else {
        printf("Uspesno ste promenili sifru.\n");
    }
}

void ispisi_nastavinke(MYSQL *connection)
{
    MYSQL_RES *result;
    char query[QUERY_SIZE];

    sprintf (query, "select * from Nastavnik");

    if (mysql_query (connection, query) != 0)
        error_fatal ("Greska u upitu %s\n", mysql_error (connection));

    result = mysql_use_result (connection);
    print_result(result);
    mysql_free_result (result);
}

void dodaj_nastavnika(MYSQL *connection)
{
    char query[QUERY_SIZE];
    char ime[BUFFER_SIZE];
    char prezime[BUFFER_SIZE];
    char korisnicko_ime[BUFFER_SIZE];
    char sifra[BUFFER_SIZE];

    printf("Dodavanje novog nastavnika:\n");
    printf("---------------------------\n");
    printf("Unsite ime: ");
    scanf("%s", ime);
    printf("Unsite prezime: ");
    scanf("%s", prezime);
    printf("Unsite korisnicko_ime: ");
    scanf("%s", korisnicko_ime);
    printf("Unsite sifru: ");
    scanf("%s", sifra);

    sprintf(query, "insert into Nastavnik (ime, prezime, korisnicko_ime, sifra) values ('%s', '%s', '%s', '%s')",
                                           ime, prezime, korisnicko_ime, sifra);

    if (mysql_query (connection, query) != 0){
        error_fatal ("Greska u upitu: %s\n", mysql_error (connection));
    }

    if (mysql_affected_rows(connection) == 0){
        printf("Nastavnik nije registrovan.\n");
    } else {
        printf("Uspesno ste registrovali nastavnika!\n");
    }
}

static void error_fatal (char *format, ...)
{
  va_list arguments;

  va_start (arguments, format);
  vfprintf (stderr, format, arguments);
  va_end (arguments);

  exit (EXIT_FAILURE);
}
