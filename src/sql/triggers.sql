USE system_pro

DELIMITER $$

DROP TRIGGER IF EXISTS povracaj_dela_rate $$

CREATE TRIGGER povracaj_dela_rate BEFORE INSERT ON Rata
FOR EACH ROW BEGIN
  DECLARE uplaceno_ukupno INT;
  DECLARE cena_godine INT;

  SET uplaceno_ukupno = (SELECT SUM(r.iznos) FROM Rata r
     WHERE r.id_godine = id_godine AND r.id_ucenika = id_ucenika);

  IF (EXISTS(SELECT * FROM Stipendija s WHERE s.id_ucenika = id_ucenika)) THEN
    SET cena_godine = (SELECT cena FROM godina g WHERE g.id_godine = id_godine);
  ELSE
    SET cena_godine = (SELECT cena_za_talentovane FROM godina g WHERE g.id_godine = id_godine);
  END IF;

  IF (uplaceno_ukupno > cena_godine) THEN
    INSERT INTO Povracaj VALUES ('',iznos + cena_godine - uplaceno_ukupno);
    SET NEW.iznos = uplaceno_ukupno - cena_godine;
  END IF;
END $$


DROP TRIGGER IF EXISTS dodavanje_ucenika_sifra $$

CREATE TRIGGER dodavanje_ucenika_sifra BEFORE INSERT ON Ucenik
FOR EACH ROW BEGIN
    SET NEW.sifra = MD5(NEW.sifra);
END$$


DROP TRIGGER IF EXISTS izmena_ucenika_sifra$$

CREATE TRIGGER izmena_ucenika_sifra BEFORE UPDATE ON Ucenik
FOR EACH ROW BEGIN
    IF (MD5(NEW.sifra) <> OLD.sifra) THEN
        set NEW.sifra = MD5(NEW.sifra);
    END IF;
END$$


DROP TRIGGER IF EXISTS dodavanje_roditelja_sifra $$

CREATE TRIGGER dodavanje_roditelja_sifra BEFORE INSERT ON Roditelj
FOR EACH ROW BEGIN
    SET NEW.sifra = MD5(NEW.sifra);
END$$


DROP TRIGGER IF EXISTS izmena_roditelja_sifra$$

CREATE TRIGGER izmena_roditelja_sifra BEFORE UPDATE ON Roditelj
FOR EACH ROW BEGIN
    IF (MD5(NEW.sifra) <> OLD.sifra) THEN
        set NEW.sifra = MD5(NEW.sifra);
    END IF;
END$$


DROP TRIGGER IF EXISTS dodavanje_nastavnika_sifra $$

CREATE TRIGGER dodavanje_nastavnika_sifra BEFORE INSERT ON Nastavnik
FOR EACH ROW BEGIN
    SET NEW.sifra = MD5(NEW.sifra);
END$$


DROP TRIGGER IF EXISTS izmena_nastavnika_sifra$$

CREATE TRIGGER izmena_nastavnika_sifra BEFORE UPDATE ON Nastavnik
FOR EACH ROW BEGIN
    IF (MD5(NEW.sifra) <> OLD.sifra) THEN
        set NEW.sifra = MD5(NEW.sifra);
    END IF;
END$$

DELIMITER ;
