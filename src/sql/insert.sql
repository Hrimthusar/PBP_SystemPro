USE system_pro;

INSERT INTO Godina (godina,cena,cena_za_talentovane) VALUES (1,10000,1000);
INSERT INTO Godina (godina,cena,cena_za_talentovane) VALUES (2,10000,2000);
INSERT INTO Godina (godina,cena,cena_za_talentovane) VALUES (3,10000,4000);
INSERT INTO Godina (godina,cena,cena_za_talentovane) VALUES (4,10000,6000);
INSERT INTO Godina (godina,cena,cena_za_talentovane) VALUES (5,10000,8000);
INSERT INTO Godina (godina,cena,cena_za_talentovane) VALUES (6,10000,10000);


INSERT INTO Grupa (id_godine,obelezje) VALUES (1,'A');
INSERT INTO Grupa (id_godine,obelezje) VALUES (1,'B');
INSERT INTO Grupa (id_godine,obelezje) VALUES (1,'C');
INSERT INTO Grupa (id_godine,obelezje) VALUES (1,'D');

INSERT INTO Grupa (id_godine,obelezje) VALUES (2,'A');
INSERT INTO Grupa (id_godine,obelezje) VALUES (2,'B');
INSERT INTO Grupa (id_godine,obelezje) VALUES (2,'C');
INSERT INTO Grupa (id_godine,obelezje) VALUES (2,'D');

INSERT INTO Grupa (id_godine,obelezje) VALUES (3,'A');
INSERT INTO Grupa (id_godine,obelezje) VALUES (3,'B');
INSERT INTO Grupa (id_godine,obelezje) VALUES (3,'C');
INSERT INTO Grupa (id_godine,obelezje) VALUES (3,'D');

INSERT INTO Grupa (id_godine,obelezje) VALUES (4,'A');
INSERT INTO Grupa (id_godine,obelezje) VALUES (4,'B');
INSERT INTO Grupa (id_godine,obelezje) VALUES (4,'C');
INSERT INTO Grupa (id_godine,obelezje) VALUES (4,'D');

INSERT INTO Grupa (id_godine,obelezje) VALUES (5,'A');
INSERT INTO Grupa (id_godine,obelezje) VALUES (5,'B');
INSERT INTO Grupa (id_godine,obelezje) VALUES (5,'C');
INSERT INTO Grupa (id_godine,obelezje) VALUES (5,'D');

INSERT INTO Grupa (id_godine,obelezje) VALUES (6,'A');
INSERT INTO Grupa (id_godine,obelezje) VALUES (6,'B');
INSERT INTO Grupa (id_godine,obelezje) VALUES (6,'C');
INSERT INTO Grupa (id_godine,obelezje) VALUES (6,'D');


INSERT INTO Roditelj (ime,prezime,korisnicko_ime,sifra) VALUES ('Roditelj','1','roditelj1','123');
INSERT INTO Roditelj (ime,prezime,korisnicko_ime,sifra) VALUES ('Roditelj','2','roditelj2','123');
INSERT INTO Roditelj (ime,prezime,korisnicko_ime,sifra) VALUES ('Roditelj','3','roditelj3','123');
INSERT INTO Roditelj (ime,prezime,korisnicko_ime,sifra) VALUES ('Roditelj','4','roditelj4','123');
INSERT INTO Roditelj (ime,prezime,korisnicko_ime,sifra) VALUES ('Roditelj','5','roditelj5','123');
INSERT INTO Roditelj (ime,prezime,korisnicko_ime,sifra) VALUES ('Roditelj','6','roditelj6','123');


INSERT INTO Ucenik (ime,prezime,id_grupe,korisnicko_ime,sifra) VALUES ('Ucenik','1',NULL,'ucenik1','123');
INSERT INTO Ucenik (ime,prezime,id_grupe,korisnicko_ime,sifra) VALUES ('Ucenik','2',NULL,'ucenik2','123');
INSERT INTO Ucenik (ime,prezime,id_grupe,korisnicko_ime,sifra) VALUES ('Ucenik','3',NULL,'ucenik3','123');
INSERT INTO Ucenik (ime,prezime,id_grupe,korisnicko_ime,sifra) VALUES ('Ucenik','4',NULL,'ucenik4','123');
INSERT INTO Ucenik (ime,prezime,id_grupe,korisnicko_ime,sifra) VALUES ('Ucenik','5',NULL,'ucenik5','123');
INSERT INTO Ucenik (ime,prezime,id_grupe,korisnicko_ime,sifra) VALUES ('Ucenik','6',NULL,'ucenik6','123');


INSERT INTO Roditelj_Ucenik (id_ucenika, id_roditelja) VALUES (1,1);
INSERT INTO Roditelj_Ucenik (id_ucenika, id_roditelja) VALUES (2,2);
INSERT INTO Roditelj_Ucenik (id_ucenika, id_roditelja) VALUES (3,3);
INSERT INTO Roditelj_Ucenik (id_ucenika, id_roditelja) VALUES (4,4);
INSERT INTO Roditelj_Ucenik (id_ucenika, id_roditelja) VALUES (5,5);
INSERT INTO Roditelj_Ucenik (id_ucenika, id_roditelja) VALUES (6,6);


INSERT INTO Stipendija (id_ucenika, broj_poena_na_testu) VALUES (1,100);
INSERT INTO Stipendija (id_ucenika, broj_poena_na_testu) VALUES (2,100);
INSERT INTO Stipendija (id_ucenika, broj_poena_na_testu) VALUES (3,100);


UPDATE Ucenik SET id_grupe = 1  WHERE id_ucenika = 1;
UPDATE Ucenik SET id_grupe = 5  WHERE id_ucenika = 2;
UPDATE Ucenik SET id_grupe = 9  WHERE id_ucenika = 3;
UPDATE Ucenik SET id_grupe = 13 WHERE id_ucenika = 4;
UPDATE Ucenik SET id_grupe = 17 WHERE id_ucenika = 5;
UPDATE Ucenik SET id_grupe = 19 WHERE id_ucenika = 6;


INSERT INTO Nastavnik (ime,prezime,korisnicko_ime,sifra) VALUES ('Nastavnik','1','nastavnik1','123');
INSERT INTO Nastavnik (ime,prezime,korisnicko_ime,sifra) VALUES ('Nastavnik','2','nastavnik2','123');
INSERT INTO Nastavnik (ime,prezime,korisnicko_ime,sifra) VALUES ('Nastavnik','3','nastavnik3','123');
INSERT INTO Nastavnik (ime,prezime,korisnicko_ime,sifra) VALUES ('Nastavnik','4','nastavnik4','123');
INSERT INTO Nastavnik (ime,prezime,korisnicko_ime,sifra) VALUES ('Nastavnik','5','nastavnik5','123');
INSERT INTO Nastavnik (ime,prezime,korisnicko_ime,sifra) VALUES ('Nastavnik','6','nastavnik6','123');
