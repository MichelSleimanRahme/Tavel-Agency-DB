CREATE OR REPLACE FUNCTION nbvoyage0(
	type varchar2(255)
	)
RETURN number 
IS 
   total number(2) := 0; 

BEGIN 
   total =  SELECT COUNT(idv) 
   			FROM VOYAGE LEFT JOIN BUS
   			WHERE VOYAGE.bus = BUS.numb 
				  AND BUS.typebus = type
				  AND annee = EXTRACT(YEAR FROM CURRENT_DATE);
    
   RETURN total; 
END; 
/ 




CREATE OR REPLACE FUNCTION nbvoyage1(
	nomex varchar2(255)
	)
RETURN number 
IS 
   total number := 0; 

BEGIN 
   total =  SELECT COUNT(idv) 
   			FROM VOYAGE LEFT JOIN BUS
   			WHERE VOYAGE.bus = BUS.numb 
				  AND BUS.typebus = type;
    
   RETURN total; 
END; 
/ 




CREATE OR REPLACE FUNCTION nbreservation(
	numclient number
	)
RETURN number 
IS 
   total number := 0; 

BEGIN 
   total =  SELECT COUNT(idr) 
   			FROM RESERVATION
   			WHERE CLIENTS.numclient = numclient;
				  
    
   RETURN total; 
END; 
/ 

CREATE FUNCTION nbreservation(
	tel varchar2(255)
	)
RETURN number 
IS 
   total number := 0; 

BEGIN 
   total =  SELECT COUNT(idr) 
   			FROM RESERVATION
   			WHERE CLIENTS.tel = tel;
				  
    
   RETURN total; 
END; 
/ 


