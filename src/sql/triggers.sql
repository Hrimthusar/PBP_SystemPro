USE system_pro
DELIMITER $$


DROP TRIGGER IF EXISTS dodavanje_ucenika_sifra $$

CREATE TRIGGER dodavanje_ucenika_sifra BEFORE INSERT ON Ucenik
FOR EACH ROW BEGIN
    SET NEW.sifra = MD5(NEW.sifra);
END$$


DROP TRIGGER IF EXISTS izmena_ucenika_sifra_i_kreiranje_rata$$

CREATE TRIGGER izmena_ucenika_sifra_i_kreiranje_rata BEFORE UPDATE ON Ucenik
FOR EACH ROW BEGIN

    DECLARE iznos_rate INT;

    DECLARE trenutna_godina INT;
    SET trenutna_godina = (SELECT id_godine FROM Grupa g WHERE g.id_grupe = new.id_grupe);

    IF ((old.id_grupe IS NULL AND new.id_grupe IS NOT NULL) OR (new.id_grupe <> old.id_grupe AND new.id_grupe IS NOT NULL)) THEN
        IF (EXISTS (SELECT * FROM Stipendija s WHERE s.id_ucenika = id_ucenika)) THEN
            SET iznos_rate = (SELECT cena_za_talentovane FROM godina g WHERE g.id_godine = trenutna_godina) / 4;
        ELSE
            SET iznos_rate = (SELECT cena FROM godina g WHERE g.id_godine = trenutna_godina) / 4;
        END IF;
        INSERT INTO Rata (iznos, id_godine, id_ucenika, rb_rate)
            Values (iznos_rate, trenutna_godina, new.id_ucenika, 1);
        INSERT INTO Rata (iznos, id_godine, id_ucenika, rb_rate)
            Values (iznos_rate, trenutna_godina, new.id_ucenika, 2);
        INSERT INTO Rata (iznos, id_godine, id_ucenika, rb_rate)
            Values (iznos_rate, trenutna_godina, new.id_ucenika, 3);
        INSERT INTO Rata (iznos, id_godine, id_ucenika, rb_rate)
            Values (iznos_rate, trenutna_godina, new.id_ucenika, 4);
    END IF;

    SET NEW.sifra = MD5(NEW.sifra);
END$$


DROP TRIGGER IF EXISTS dodavanje_roditelja_sifra $$

CREATE TRIGGER dodavanje_roditelja_sifra BEFORE INSERT ON Roditelj
FOR EACH ROW BEGIN
    SET NEW.sifra = MD5(NEW.sifra);
END$$


DROP TRIGGER IF EXISTS izmena_roditelja_sifra$$

CREATE TRIGGER izmena_roditelja_sifra BEFORE UPDATE ON Roditelj
FOR EACH ROW BEGIN
    set NEW.sifra = MD5(NEW.sifra);
END$$


DROP TRIGGER IF EXISTS dodavanje_nastavnika_sifra $$

CREATE TRIGGER dodavanje_nastavnika_sifra BEFORE INSERT ON Nastavnik
FOR EACH ROW BEGIN
    SET NEW.sifra = MD5(NEW.sifra);
END$$


DROP TRIGGER IF EXISTS izmena_nastavnika_sifra$$

CREATE TRIGGER izmena_nastavnika_sifra BEFORE UPDATE ON Nastavnik
FOR EACH ROW BEGIN
    set NEW.sifra = MD5(NEW.sifra);
END$$

DELIMITER ;
