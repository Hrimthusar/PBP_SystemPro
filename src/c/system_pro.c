#include "system_pro.h"
#include "sql.h"

void administracija(MYSQL* connection);
void nastavnik(MYSQL* connection);
void roditelj(MYSQL* connection);
void ucenik(MYSQL* connection);

void dug(MYSQL* connection, char* korisnicko_ime);
void prijavi_projekat(MYSQL* connection, char* korisnicko_ime);

void ispisi(MYSQL* connection);


int main (int argc, char **argv)
{
    MYSQL* connection;
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

    while(running){
        system("clear");
        printf("\n/--------------------------------\\\n");
        printf("| Skola programiranja SYSTEM PRO |\n");
        printf("\\--------------------------------/\n\n");
        printf("- \e[4mA\e[24mdministracija\n"); // _Administracija
        printf("- \e[4mN\e[24mastavnik\n"); // _Nastavnik
        printf("- \e[4mU\e[24mcenik\n"); // _Ucenik
        printf("- \e[4mR\e[24moditelj\n"); // _Roditelj
        printf("- \e[4mK\e[24mraj\n"); // _Kraj

        printf("Unesite podvuceni karakter: ");
        scanf("%s", option);
        printf("\n");

        switch (option[0]) {
            case 'a':
            case 'A':
                administracija(connection);
                break;
            case 'n':
            case 'N':
                nastavnik(connection);
                break;
            case 'u':
            case 'U':
                ucenik(connection);
                break;
            case 'r':
            case 'R':
                roditelj(connection);
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

void administracija(MYSQL* connection){
    char option[2];
    int logged = 1;

    while(logged){
        system("clear");
        printf("- \e[4mI\e[24mspisi\n"); // _Ispisi
        printf("- Registruj \e[4mn\e[24mastavnika\n"); // Registruj _nastavinka
        printf("- \e[4mP\e[24mromeni grupu uceniku\n"); // _Promeni grupu uceniku
        printf("- N\e[4ma\e[24mzad\n"); // N_azad


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
                ispisi_nastavnike(connection, DONT_WAIT);
                dodaj_nastavnika(connection);
                ispisi_nastavnike(connection, WAIT);
                break;
            case 'p':
            case 'P':
                ispisi_ucenike(connection, DONT_WAIT);
                promeni_grupu(connection);
                ispisi_ucenike(connection, WAIT);
                break;
            case 'a':
            case 'A':
                logged = 0;
                break;
            case '\n':
                break;
            default:
                system("clear");
                printf("Pogresan ulaz\n");
                break;
        }
    }
}

void nastavnik(MYSQL* connection){
    char* korisnicko_ime = uloguj_se(connection, NASTAVNIK);
    if(korisnicko_ime == NULL)
        return;

    char option[2];
    int logged = 1;

    while(logged){
        system("clear");
        printf("- Promeni \e[4ms\e[24mifru nastavniku\n"); // Promeni _sifru
        printf("- \e[4mO\e[24mdjavite se\n"); // _Odjavite se

        printf("Unesite podvuceni karakter: ");
        scanf("%s", option);
        printf("\n");

        switch (option[0]) {
            case 's':
            case 'S':
                promeni_sifru_nastavniku(connection, korisnicko_ime);
                break;
            case 'o':
            case 'O':
                logged=0;
            case '\n':
                break;
            default:
                system("clear");
                printf("Pogresan ulaz\n");
                break;
        }
    }
    free(korisnicko_ime);
}

void ucenik(MYSQL* connection){
    char* korisnicko_ime = uloguj_se(connection, UCENIK);
    if(korisnicko_ime == NULL)
        return;

    char option[2];
    int logged = 1;

    while(logged){
        system("clear");
        printf("- \e[4mP\e[24mrojekti (trenutni)\n"); // _Projekti (trenutni)
        printf("- P\e[4mr\e[24mijavi se za projekat\n"); // P_rijavi se za projekat
        printf("- \e[4mO\e[24mdjavite se\n"); // _Odjavite se


        printf("Unesite podvuceni karakter: ");
        scanf("%s", option);
        printf("\n");

        switch (option[0]) {
            case 'p':
            case 'P':
                ispisi_projekte(connection, korisnicko_ime);
                break;
            case 'r':
            case 'R':
                prijavi_projekat(connection, korisnicko_ime);
                break;
            case 'o':
            case 'O':
                logged=0;
            case '\n':
                break;
            default:
                system("clear");
                printf("Pogresan ulaz\n");
                break;
        }
    }
    free(korisnicko_ime);
}

void roditelj(MYSQL* connection){
    char* korisnicko_ime = uloguj_se(connection, RODITELJ);
    if(korisnicko_ime == NULL)
        return;

    char option[2];
    int logged = 1;

    while(logged){
        system("clear");
        printf("- \e[4mD\e[24mug\n"); // _Dug
        printf("- \e[4mP\e[24mlaceno\n"); // _Placeno
        printf("- \e[4mO\e[24mdjavite se\n"); // _Odjavite se

        printf("Unesite podvuceni karakter: ");
        scanf("%s", option);
        printf("\n");

        switch (option[0]) {
            case 'd':
            case 'D':
                dug(connection, korisnicko_ime);
                break;
            case 'p':
            case 'P':
                ispisi_placeno(connection, korisnicko_ime);
                break;
            case 'o':
            case 'O':
                logged=0;
            case '\n':
                break;
            default:
                system("clear");
                printf("Pogresan ulaz\n");
                break;
        }
    }
    free(korisnicko_ime);
}

void dug(MYSQL* connection, char* korisnicko_ime)
{
    ispisi_rate(connection, korisnicko_ime, DONT_WAIT);
    printf("\n\nUnesite id_rate da biste uplatili: ");
    char id_rate[5];
    scanf("%s", id_rate);
    printf("\n\n");
    plati_ratu(connection, id_rate, korisnicko_ime);
    ispisi_rate(connection, korisnicko_ime, WAIT);
}

void prijavi_projekat(MYSQL* connection, char* korisnicko_ime){
    ispisi_solobodne_projekte(connection, korisnicko_ime);
    printf("\n\nUnesite id_rate da biste uplatili: ");
    char id_projekta[5];
    scanf("%s", id_projekta);
    printf("\n\n");
    radi_na_projektu(connection, id_projekta, korisnicko_ime);
    ispisi_solobodne_projekte(connection, korisnicko_ime);
    getchar();
    getchar();
}

void ispisi(MYSQL* connection){
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
            ispisi_nastavnike(connection, WAIT);
            break;
        case 'u':
        case 'U':
            ispisi_ucenike(connection, WAIT);
            break;
        case 'r':
        case 'R':
            ispisi_roditelje(connection);
            break;
        case '\n':
            break;
        default:
            system("clear");
            printf("Pogresan ulaz\n");
            break;
    }
}
