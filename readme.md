# Tema: Skola programiranja SystemPro

## Opis dokumenata

Nezavisni entiteti:
- Ucenik
- Roditelj
- Nastavnik
- Godina
- Grupa
- Rata
- Projekat

Zavisni entiteti:
- Uplatnica
- Stipendija
- Povracaj

Agregirani entiteti:
- Roditelj_Ucenik
- Predaje
- Radi_Na_Projektu

Trigeri:
- Pre unosenja rate proverava se da li je zbir cena svih rata veci od cene godine, i ako da rata se postavlja na potreban iznos, a ostatak novca se vraca roditelju.
- Pre unosenja rate, ukoliko je ucenik u tabeli Stipendija, proverava se da li je zbir cena svih rata veci od vrednosti cena_za_stipendiste godine, i ako da rata se postavlja na potreban iznos, a ostatak novca se vraca roditelju.
- Pre unosenja sifre za studenta ili roditelja, ona se hashuje.
- Prilikom promene sifre za studenta ili roditelja, ako je razlicita od prethodne, hesira se.

### Ucenik
Svaki ucenik ima svoj nalog. Kada ucenik zavrsi poslednju godinu, brise se iz evidencije.
- ime
- prezime
- id_grupe: za ucenika se pamti grupa u kojoj slusa predavanja
- korisnicko_ime: korisnicko ime kojim ucenik pristupa sistemu
- sifra: hesirana lozinka

### Roditelj
Roditelj ima uvid u finansije ali ne mogu da vide materijal i ostale stvari koje su potrebne uceniku. Nastavnici mogu da im se obracaju, zakazuju roditeljske sastanke, itd...
- ime
- prezime
- korisnicko_ime: korisnicko ime kojim roditelj pristupa sistemu
- sifra: hesirana lozinka

### Nastavnik
Svaki nastavnik drzi nastavu celoj grupi jedne godine (svaki predmet), i moze da predaje vise grupa.
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
Po prelasku u drugu godinnu, menja se id_godine grupe, dok obelezje ostaje isto. Kada ucenici zavrse poslednju godinu, grupa se brise iz evidencije.
- id_godine: godina koju grupa pohadja
- obelezje: neki "naziv" grupe ("A,B,C,Prva,Druga"), zavisi od konvencije same skole

### Rata
Sadrzi informacije o uplatiocu (roditelju), uceniku za koga se uplacuje i godinu koju ucenik slusa (da bi te informacije bile uvek dostpune).
- iznos: uplacena kolicina novca
- id_ucenika: ucenik za koga je izvrsena uplata
- id_godine: godina koju ucenik pohadja (je pohadjao)

### Uplatnica
Sadrzi dodatne informacije o uplati novca za potrebe knjigovodstva
- id_rate: rata za koju je vezana uplatnica.
- datum_uplate
- id_roditelja: roditelj koji je izvrsio uplatu

### Stipendija
Sadrzi informaciju o ucenicima koji su dobro plasirani na prijemnom ispitu (najboljih 30), koji jeftinije placaju skolarinu.
- id_ucenika
- broj_poena_na_testu

### Povracaj
Sadrzi informacije o povracaju novca ukoliko je uplaceno vise nego sto je potrebno.
- id_rate
- iznos

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
