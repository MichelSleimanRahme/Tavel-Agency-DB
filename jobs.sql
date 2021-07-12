BEGIN 
DBMS_SCHEDULER.create_job(
	job_name 		=> 'HistExUpt',
	job_type 		=> 'PLSQL_BLOCK',
	job_action 		=> 'DECLARE CURSOR nyUpt IS SELECT nomex FROM EXCURSION;
						DECLARE cur_ex varchar();
						
						OPEN nyUpt;
						
						FOR index 1 .. (SELECT COUNT(*) FROM EXCURSION)
							FETCH FROM EXCURSION INTO cur_ex;
						
							INSERT INTO HIST_EX (nomex, annee)
							VALUES (cur_ex, YEAR(GETDATE()));
						END LOOP;',
	
	start_date 		=> SYSTIMESTAMP,
	repeat_interval => 'freq=YEARLY; interval = 1',
	end_date 		=> NULL,
	enabled 		=> TRUE,
	comments		=> '');
	END;
);
END;