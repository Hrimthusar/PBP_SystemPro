# Skola programiranja SystemPro

## Opis problema
Baza za skolu programiranja System Pro sluzi kao podrska kako ucenicima, tako i profesorima i roditeljima.

U bazi se cuvaju informacije o svim korisnicima, godinama i grupama, kao i vezama izmedju nastavnika i grupa, roditelja i ucenika, itd..

Ucenik moze da se informise o novim projektima, da ih prijavljuje i da prati one na kojima vec radi, nastavnici mogu da imaju uvid o svojim grupama i ucenicima, dok roditelji mogu da vrse uplate. Takodje administrator sistema moze da ima uvid o svim korisnicima, menja osetljive podatke, itd...

Vise u opisu entiteta i opisu implementacije...


## Entiteti

###### Nezavisni entiteti:
- Ucenik
- Roditelj
- Nastavnik
- Godina
- Grupa
- Rata
- Projekat

###### Zavisni entiteti:
- Uplatnica
- Stipendija

###### Agregirani entiteti:
- Roditelj_Ucenik
- Predaje
- Radi_Na_Projektu

### Ucenik
Svaki ucenik ima svoj nalog. Kada ucenik zavrsi poslednju godinu, grupa mu se stavlja na NULL. Ucenik se ostavlja u bazi da bi skola eventualno mogla da mu salje informacije u buducnosti o partnerskim firmama, ponudama za posao, itd...
- ime
- prezime
- id_grupe: za ucenika se pamti grupa u kojoj slusa predavanja ili NULL ako je tek upisao ili vec zavrsio
- korisnicko_ime: korisnicko ime kojim ucenik pristupa sistemu
- sifra: hesirana lozinka

### Roditelj
Roditelj ima uvid u finansije ali ne mogu da vide informacije o projektima i ostale stvari koje su potrebne uceniku. Nastavnici mogu da im se obracaju, zakazuju roditeljske sastanke, itd...
- ime
- prezime
- korisnicko_ime: korisnicko ime kojim roditelj pristupa sistemu
- sifra: hesirana lozinka

### Nastavnik
Svaki nastavnik drzi nastavu celoj grupi jedne godine (svaki predmet), i moze da predaje vise grupa. Takodje moze da bude mentor na projektima.
- ime
- prezime
- korisnicko_ime: korisnicko ime kojim nastavnik pristupa sistemu
- sifra: hesirana lozinka

### Godina
Sadrzi informacije o rednom broju godine i o ceni / ceni za talentovane.
- godina: redni broj godine (1,2,3,...)
- cena: redovna cena godine
- cena_za_talentovane: cena godine sa popustom za talentovanu decu

### Grupa
Grupu pohadja odredjeni broj ucenika na jednoj godini.
Po prelasku u drugu godinu, menja se id_godine grupe ucenika. Grupa se moze izabrati da ima isto obelezje kao prethodna, ali ukoliko ucenik ima razlog, sistem dopusta i da ne bude ista.
- id_godine: godina koju grupa pohadja
- obelezje: neki "naziv" grupe ("A,B,C")

### Rata
Sadrzi informacije o iznosu koji treba da se uplati, kao i za kog ucenika u kojoj godini se placa. Sistem generise 4 jednake mesecne rate (okidac)
- iznos: uplacena kolicina novca
- id_ucenika: ucenik za koga je izvrsena uplata
- id_godine: godina koju ucenik pohadja (je pohadjao)
- rb_rate: (1, 2, 3, 4)

### Uplatnica
Sadrzi informacije o uplacenoj rati
- id_rate: rata za koju je vezana uplatnica.
- datum_uplate
- id_roditelja: roditelj koji je izvrsio uplatu

### Stipendija
Sadrzi informaciju o ucenicima koji su dobro plasirani na prijemnom ispitu (najboljih 30), koji jeftinije placaju skolarinu.
- id_ucenika
- broj_poena_na_testu

### Roditelj_Ucenik
Veza izmedju roditelja i ucenika (otac i majka mogu da poseduju nalog za jednog ucenika, i roditelj moze imati vise dece).
- id_ucenika
- id_roditelja

### Predaje
Veza izmedju nastavnika i ucenika.
- id_grupe
- id_nastavnika
- broj_ucionice

### Projekat
Programerski projekat koji moze da radi jedan ili vise ucenika sa mentorom (nastavnikom).
- id_nastavnika: jedan od redovnih nastavnika je mentor na projektu
- naziv
- opis
- url: adresa na kojoj ce moci da se vidi projekat

### Radi_Na_Projektu
Veza ucenika i projekta (ucenik moze da radi vise projekata, i projekat moze da radi vise ucenika).
- id_ucenika
- id_projekta

## Trigeri:
- Pri promeni grupe ucenika, ako je grupa u razlicitoj godini od stare i nije NULL, kreiraju se 4 mesecne rate. Takodje se vodi racuna o tome da li je ucenik stipendista, sto smanjuje iznos rate.
- Pre unosenja sifre za nastavinka, ucenika ili roditelja, ona se hashuje.
- Prilikom promene sifre za nastavinka, ucenika ili roditelja, ako je razlicita od prethodne, hesira se.

## C Implementacija:

 Program se sastoji iz 4 glavna dela (administracija, nastavink, ucenik, roditelj)

### Administracija:
Administracija opisuje deo programa koji se bavi registrovanjem novih korisnika, promenama osetljivih podataka itd...

Od funkcionalnosti su implementirane:
- Ispisi svih korisnika (nastavnika, ucenika, roditelja)
- Registracija novog id_nastavnika
- Promena grupe ucenika

### Nastavnik:
Za pristup ovom delu potrebno je ulogovati se kao vec postojeci nastavnik. Nakon toga ulogovani nastavnik moze da obavlja svoj posao.

Od funkcionalnosti je implementirana:
- Promena sifre

### Ucenik:
Za pristup ovom delu potrebno je ulogovati se kao vec postojeci ucenik. Nakon toga ulogovani ucenik moze da obavlja svoj posao.

Od funkcionalnosti su implementirane:
- Listanje trenutnih projekata na kojima radi ucenik
- Prijava na projekat koji vec postoji, ali ucenik trenutno ne radi na njemu

### Roditelj:
Za pristup ovom delu potrebno je ulogovati se kao vec postojeci roditelj. Nakon toga ulogovani roditelj moze da obavlja svoj posao.

Od funkcionalnosti su implementirane:
- Placanje neizmirenog duga (rate za svoje dete)
- Pregled uplatnica (vec placenih rata)

### Uputstvo:
Prilikom pokretanja programa make, pokrecu se skripte koje kreiraju bazu, kreiraju okidace nad njom i ubacuju podatke za testiranje. Ukoliko zelite da se ulogujete na nastavnika / roditelja / ucenika, koristite bas tu rec kao prefiks, za kojom ide broj iz skupa {1,..,6} (npr. ucenik1). Sifra je za sve ista: 123. Ostale inicijalne podatke mozete pogledati u src/sql/insert.slq

Korisnicko ime za bazu je root, sifre nema.


Program je pisan na macOS, zbog cega treba obratiti paznju na sledece stvari. U fajlu src/Makefile, program se linkuje sa mysql bibliotekom verzije 5.7.20 i nalazi se na tamo oznacenoj lokaciji. Takodje sistem nije case sensitive.
