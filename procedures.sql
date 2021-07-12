CREATE OR REPLACE PROCEDURE HistEx_Fill () 
IS
BEGIN

DECLARE CURSOR Histc IS SELECT nomex FROM EXCURSION;
DECLARE year:=0;
DECLARE cur_var varchar();


FOR index0 IN 1 .. (SELECT COUNT(*) FROM EXCURSION) 
LOOP

OPEN Histc;

year := MIN(YEAR(VOYAGE.datev)) - 1;
FETCH FROM Histc INTO cur_var;

	FOR index1 IN 1 .. (SELECT COUNT(DISTINCT YEAR(datev)) FROM VOYAGE)
		
		INSERT INTO HIST_EX (annee, nomex)
		VALUES (year+1, cur_var);



	END LOOP;

CLOSE Histc;

END LOOP;

UPDATE HIST_EX
SET nbvoyages = SELECT COUNT(*)
				FROM VOYAGE RIGHT JOIN HIST_EX
				WHERE YEAR(VOYAGE.datev) = HIST_EX.annee
					AND VOYAGE.nomex = HIST_EX.nomex


UPDATE HIST_EX
SET nbreservations = SELECT COUNT(*)
				FROM RESERVATION RIGHT JOIN VOYAGE 
				WHERE RESERVATION.idv = VOYAGE.idv
					AND VOYAGE.nomex = HIST_EX.nomex
					AND YEAR(VOYAGE.datev) = HIST_EX.annee


UPDATE HIST_EX
SET revenu = 	(SELECT COUNT(*)
				FROM RESERVATION RIGHT JOIN VOYAGE 
				WHERE RESERVATION.idv = VOYAGE.idv
					AND VOYAGE.nomex = HIST_EX.nomex
					AND YEAR(VOYAGE.datev) = HIST_EX.annee) * (SELECT EXCURSION.prix
																FROM EXCURSION INNER JOIN HIST_EX
																)




END;
/




CREATE OR REPLACE PROCEDURE PFix () 
IS
BEGIN

DECLARE max0 varchar;
DECLARE max1 varchar;
DECLARE max2 varchar;

SELECT max0 = nomex
	FROM HIST_EX
	WHERE nbreservations =  (SELECT MAX(nbreservations)
							FROM HIST_EX
							);

SELECT max1 = nomex
	FROM HIST_EX
	WHERE nbreservations =  SELECT MAX(nbreservations)
							FROM HIST_EX
							WHERE (nbreservations < SELECT MAX(nbreservations)
													FROM HIST_EX);


SELECT max2 = nomex
	FROM HIST_EX
	WHERE nbreservations = SELECT nbreservations 
						   FROM (SELECT nbreservations 
	 							 FROM HIST_EX ORDER BY nbreservations DESC
	 							 WHERE ROWID = 3 )

UPDATE EXCURSION
SET EXCURSION.PRIX = EXCURSION.PRIX*1.13
WHERE nomex = max0; 	

UPDATE EXCURSION
SET EXCURSION.PRIX = EXCURSION.PRIX*1.10
WHERE nomex = max1;

  							 
UPDATE EXCURSION
SET EXCURSION.PRIX = EXCURSION.PRIX*1.07
WHERE nomex = max2;  							 


END;
/




CREATE OR REPLACE PROCEDURE SalFix () 
IS
BEGIN 

DECLARE maxc0 number; 
DECLARE maxc1 number;
DECLARE maxh0 number;
DECLARE maxh1 number;




SELECT       maxc0 = chauffeur,
             COUNT(chauffeur) AS `cc0` 
    FROM     VOYAGE
    GROUP BY chauffeur
    ORDER BY `cc0` DESC
    LIMIT    1
    WHERE YEAR(datev) = YEAR(get_date());


SELECT       maxc1 = chauffeur,
             COUNT(chauffeur) AS `cc1` 
    FROM     VOYAGE
    GROUP BY chauffeur
    ORDER BY `cc1` DESC
    LIMIT    1;
    WHERE (		(SELECT       maxc1 = chauffeur,
             	COUNT(chauffeur) AS `cc1` 
   				FROM     VOYAGE
    			GROUP BY chauffeur
   				ORDER BY `cc1` DESC
    			LIMIT    1;) < maxc1)
    	AND YEAR(datev) = YEAR(get_date());


SELECT       maxh0 = hotesse,
             COUNT(hotesse) AS `ch0` 
    FROM     VOYAGE
    GROUP BY hotesse
    ORDER BY `ch0` DESC
    LIMIT    1
    WHERE YEAR(datev) = YEAR(get_date());


SELECT       maxh1 = hotesse,
             COUNT(hotesse) AS `ch1` 
    FROM     VOYAGE
    GROUP BY hotesse
    ORDER BY `ch1` DESC
    LIMIT    1;
    WHERE (		(SELECT       maxc1 = hotesse,
             	COUNT(hotesse) AS `ch1` 
   				FROM     VOYAGE
    			GROUP BY hotesse
   				ORDER BY `ch1` DESC
    			LIMIT    1;) < maxc1)
    	AND YEAR(datev) = YEAR(get_date());;


UPDATE EMPLOYEE
SET salaire = salaire * 1.12   
WHERE numemp = maxc0 OR numemp = maxh0; 

UPDATE EMPLOYEE
SET salaire = salaire * 1.08 
WHERE numemp = maxc1 OR numemp = maxh1; 

END;
/