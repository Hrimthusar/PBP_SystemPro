#include "sql.h"

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

    getchar();
    getchar();
}

char* uloguj_se(MYSQL* connection, int korisnik){
    MYSQL_RES *result;
    MYSQL_ROW row;

    char query[QUERY_SIZE];

    char* korisnicko_ime = malloc(BUFFER_SIZE * sizeof(char));
    if(korisnicko_ime == NULL){
        exit(EXIT_FAILURE);
    }
    char sifra[BUFFER_SIZE];

    printf("Korisnicko ime: ");
    scanf("%s", korisnicko_ime);
    printf("Sifra: ");
    scanf("%s", sifra);

    if(korisnik == NASTAVNIK) {
        sprintf (query, "select korisnicko_ime from nastavnik where korisnicko_ime = '%s' and sifra = MD5('%s')",
                                                   korisnicko_ime, sifra);
    } else if(korisnik == UCENIK){
        sprintf (query, "select korisnicko_ime from ucenik where korisnicko_ime = '%s' and sifra = MD5('%s')",
                                                   korisnicko_ime, sifra);
    } else {
        sprintf (query, "select korisnicko_ime from roditelj where korisnicko_ime = '%s' and sifra = MD5('%s')",
                                                   korisnicko_ime, sifra);
    }

    if (mysql_query (connection, query) != 0){
        error_fatal ("Greska u upitu %s\n", mysql_error (connection));
    }
    result = mysql_use_result (connection);

    row = mysql_fetch_row(result);
    if (row == 0){
        printf("Pogresno korisnicko ime ili sifra\n");
        mysql_free_result (result);
        return NULL;
    }
    mysql_free_result (result);
    return korisnicko_ime;
}

void promeni_sifru_nastavniku(MYSQL* connection, char* korisnicko_ime)
{
    MYSQL_RES *result;
    MYSQL_ROW row;

    char sifra[BUFFER_SIZE];

    char query[QUERY_SIZE];

    printf("Izaberite novu sifru\n");
    scanf("%s", sifra);

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

void ispisi_rate(MYSQL* connection, char* korisnicko_ime){
    MYSQL_RES *result;
    MYSQL_ROW row;

    char query[QUERY_SIZE];

    sprintf(query, "select r.id_rate, u.ime, u.prezime, r.rb_rate, r.iznos \
                            from roditelj_ucenik ru \
                            join ucenik u on ru.id_ucenika = u.id_ucenika \
                            join roditelj rod on ru.id_roditelja = rod.id_roditelja \
                                            and rod.korisnicko_ime = '%s' \
                            join rata r on u.id_ucenika = r.id_ucenika \
                            join godina g on g.id_godine = r.id_godine \
                            where not exists (select * from uplatnica up where up.id_rate = r.id_rate) \
                            order by u.ime, g.godina",
                                         korisnicko_ime);

    if (mysql_query (connection, query) != 0){
        error_fatal ("Greska u upitu %s\n", mysql_error (connection));
    }

    result = mysql_use_result (connection);
    print_result(result);
    mysql_free_result (result);
}

void plati_ratu(MYSQL* connection, char* id_rate, char* korisnicko_ime){
    MYSQL_RES *result;
    MYSQL_ROW row;
    char query[QUERY_SIZE];

    char* id_roditelja;


    sprintf (query, "select id_roditelja from roditelj where korisnicko_ime = '%s'",
                                               korisnicko_ime);

    if (mysql_query (connection, query) != 0){
        error_fatal ("Greska u upitu %s\n", mysql_error (connection));
    }
    result = mysql_use_result (connection);
    row = mysql_fetch_row(result);
    id_roditelja = row[0];

    sprintf(query, "insert into Uplatnica (id_rate,datum_uplate,id_roditelja) values ('%s', NOW(), '%s')",
                                            id_rate, id_roditelja);

    mysql_free_result (result);


    if (mysql_query (connection, query) != 0){
        error_fatal ("Greska u upitu: %s\n", mysql_error (connection));
    }
}

void ispisi_nastavnike(MYSQL* connection)
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

void ispisi_ucenike(MYSQL* connection)
{
    MYSQL_RES *result;
    char query[QUERY_SIZE];

    sprintf (query, "select * from Ucenik");

    if (mysql_query (connection, query) != 0)
        error_fatal ("Greska u upitu %s\n", mysql_error (connection));

    result = mysql_use_result (connection);
    print_result(result);
    mysql_free_result (result);
}

void ispisi_roditelje(MYSQL* connection)
{
    MYSQL_RES *result;
    char query[QUERY_SIZE];

    sprintf (query, "select * from Roditelj");

    if (mysql_query (connection, query) != 0)
        error_fatal ("Greska u upitu %s\n", mysql_error (connection));

    result = mysql_use_result (connection);
    print_result(result);
    mysql_free_result (result);
}

void dodaj_nastavnika(MYSQL* connection)
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

void error_fatal (char *format, ...)
{
  va_list arguments;

  va_start (arguments, format);
  vfprintf (stderr, format, arguments);
  va_end (arguments);

  exit (EXIT_FAILURE);
}
