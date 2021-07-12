CREATE TABLE CLIENTS (
	numclient int NOT NULL AUTO_INCREMENT,
	nom varchar(255) NOT NULL,
	adresse varchar(255) NOT NULL,
	tel int NOT NULL check (phone_number between 1000000 and 99999999),
	email varchar(255) NOT NULL,
	nb_reserv NOT NULL,
	solde NOT NULL,

	CONSTRAINT PK_clients PRIMARY KEY (numclient)

);

CREATE TABLE EXCURSION (
	nomex varchar(255) NOT NULL AUTO_INCREMENT,
	libelle NOT NULL,
	depart varchar(255) NOT NULL,
	destination varchar(255) NOT NULL,
	descriptif varchar(255) NOT NULL,
	duree NOT NULL,
	prix int NOT NULL,
	
	CONSTRAINT PK_excursion PRIMARY KEY (nomex)

);

CREATE TABLE EMPLOYEE (
	numemp int NOT NULL AUTO_INCREMENT,
	nom NOT NULL,
	prenom NOT NULL,
	datenais NOT NULL,
	salaire NOT NULL,
	
	CONSTRAINT PK_employee PRIMARY KEY (numep)
);

CREATE TABLE BUS (
	numb NOT NULL AUTO_INCREMENT,
	modele NOT NULL,
	annee NOT NULL,
	typebus NOT NULL,
	
	CONSTRAINT PK_bus PRIMARY KEY (numb)
);

CREATE TABLE RESERVATION (
	idr NOT NULL AUTO_INCREMENT,
	idv NOT NULL,
	dater NOT NULL,
	numclient NOT NULL,
	
	CONSTRAINT PK_reservation PRIMARY KEY (idr),
	
	CONSTRAINT FK_reservation FOREIGN KEY (idv)
    REFERENCES VOYAGE(idv)
);

CREATE TABLE VOYAGE (
	idv NOT NULL AUTO_INCREMENT,
	nomex NOT NULL,
	datev NOT NULL,
	bus NOT NULL,
	chauffeur NOT NULL,
	hotesse NOT NULL,
	nbmax NOT NULL,
	
	CONSTRAINT PK_voyage PRIMARY KEY (idv),
	
	CONSTRAINT FK_voyage0 FOREIGN KEY (nomex)
    REFERENCES EXCURSION(nomex),

    CONSTRAINT FK_voyage1 FOREIGN KEY (bus)
    REFERENCES EXCURSION(numb),

    CONSTRAINT FK_voyage2 FOREIGN KEY (chauffeur)
    REFERENCES EXCURSION(numb),

    CONSTRAINT FK_voyage3 FOREIGN KEY (hotesse)
    REFERENCES EXCURSION(numb),
);

CREATE TABLE PAYEMENT (
	nump NOT NULL AUTO_INCREMENT,
	datep NOT NULL,
	montant NOT NULL,
	numc NOT NULL,
	
	CONSTRAINT PK_payement PRIMARY KEY (nump),

    CONSTRAINT FK_payement FOREIGN KEY (numc)
    REFERENCES CLIENTS(numclient)
);

CREATE TABLE HIST_EX (
	nomex NOT NULL,
	annee NOT NULL,
	nbvoyage NOT NULL,
	nbreservation NOT NULL,
	revenu NOT NULL,
	
	CONSTRAINT PK_hist_ex PRIMARY KEY (nomex, annee)
);
