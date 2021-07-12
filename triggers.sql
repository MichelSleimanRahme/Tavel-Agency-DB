CREATE TRIGGER NewHist_EX  
AFTER   
INSERT ON EXCURSION 
FOR EACH ROW     

BEGIN  
   
INSERT INTO HIST_EX (nomex, annee)
VALUES (INSERTED.nomex, YEAR(GETDATE()));

END; 


CREATE TRIGGER UptHIST_EX0
AFTER 
INSERT ON VOYAGE
FOR EACH ROW

BEGIN

UPDATE HIST_EX
SET HIST_EX.nbvoyages = HIST_EX.nbvoyages + 1;
WHERE HIST_EX.nomex = INSERTED.nomex;
	AND HIST_EX.annee = YEAR(INSERTED.datev);

END; 


CREATE TRIGGER UptHIST_EX1
AFTER 
INSERT ON RESERVATION
FOR EACH ROW

BEGIN

UPDATE HIST_EX
SET HIST_EX.nbreservation = HIST_EX.nbreservation + 1;
WHERE HIST_EX.nomex = VOYAGE.nomex;
	AND INSERTED.idv = VOYAGE.idv
	AND HIST_EX.annee = YEAR(INSERTED.datev);

END; 




CREATE TRIGGER MAX_res  
AFTER   
INSERT ON RESERVATION
FOR EACH ROW     
WHEN (	SELECT COUNT(*) 
		FROM RESERVATION
		WHERE RESERVATION.idv = INSERTED.idv ) > 	(SELECT nbmax
													FROM VOYAGE
													WHERE VOYAGE.idv = INSERTED.idv)
BEGIN  
   
DELETE FROM RESERVATION
WHERE RESERVATION.idr = INSERTED.idr

DBMS_OUTPUT.PUT_LINE(	'Le nombre de reservation pour le voyage souhaite 
						a atteint son maximum '); 

END; 





CREATE TRIGGER NewRes 
AFTER   
INSERT ON RESERVATION 
FOR EACH ROW     

BEGIN  
   
UPDATE CLIENTS
SET CLIENTS.solde = CLIENTS.solde + EXCURSION.prix
WHERE INSERTED.idv = VOYAGE.idv
	AND VOYAGE.nomex = EXCURSION.nomex

END; 


CREATE TRIGGER NewPay
AFTER   
INSERT ON PAYEMENT
FOR EACH ROW     

BEGIN  
   
UPDATE CLIENTS
SET CLIENTS.solde = CLIENTS.solde - PAYEMENT.montant
WHERE INSERTED.numc = CLIENTS.numclient
	

END; 