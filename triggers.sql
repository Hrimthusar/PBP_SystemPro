DELIMITER $$

DROP TRIGGER IF EXISTS povracaj_dela_rate

CREATE TRIGGER povracaj_dela_rate AFTER INSERT ON Rata
FOR EACH ROW BEGIN
  DECLARE uplaceno_ukupno INT;
  SET uplaceno_ukupno = (SELECT SUM(cena) FROM Rata r
     WHERE r.id_godine = id_godine AND r.id_ucenika = id_ucenika);

  DECLARE cena_godine INT;
  IF (EXISTS(SELECT * FROM Stipendija s WHERE s.id_ucenika = id_ucenika)) THEN
    SET cena_godine = (SELECT cena FROM godina WHERE g.id_godine = id_godine);
  ELSE
    SET cena_godine = (SELECT cena_za_talentovane FROM godina WHERE g.id_godine = id_godine);
  END IF;

  IF (uplaceno_ukupno > cena_godine) THEN
    SET cena = uplaceno_ukupno - cena_godine;
    -- ISPISATI PORUKU O POVRATKU NOVCA ILI SACUVATI NEGDE VREDNOST
  END IF;
END $$


DROP TRIGGER IF EXISTS dodavanje_ucenika_sifra $$

CREATE TRIGGER dodavanje_ucenika_sifra BEFORE INSERT ON Ucenik
FOR EACH ROW BEGIN
    SET new.sifra = MD5(new.sifra);
END$$


DROP TRIGGER IF EXISTS izmena_ucenika_sifra$$

CREATE TRIGGER izmena_ucenika_sifra BEFORE UPDATE ON Ucenik
FOR EACH ROW BEGIN
    IF (MD5(new.sifra) <> old.sifra) THEN
        set new.sifra = MD5(new.sifra);
    END IF;
END$$


DROP TRIGGER IF EXISTS dodavanje_roditelja_sifra $$

CREATE TRIGGER dodavanje_roditelja_sifra BEFORE INSERT ON Roditelj
FOR EACH ROW BEGIN
    SET new.sifra = MD5(new.sifra);
END$$


DROP TRIGGER IF EXISTS izmena_roditelja_sifra$$

CREATE TRIGGER izmena_roditelja_sifra BEFORE UPDATE ON Roditelj
FOR EACH ROW BEGIN
    IF (MD5(new.sifra) <> old.sifra) THEN
        set new.sifra = MD5(new.sifra);
    END IF;
END$$

DELIMITER ;
