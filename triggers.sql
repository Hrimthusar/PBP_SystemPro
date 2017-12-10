DELIMITER $$

DROP TRIGGER IF EXISTS rata_trigger

CREATE TRIGGER rata_trigger AFTER INSERT ON Rata
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

DELIMITER ;
