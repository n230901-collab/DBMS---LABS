USE gram_panchayat;
SET AUTOCOMMIT = 0;
SELECT @@AUTOCOMMIT;
-- Task 1
START TRANSACTION;
UPDATE certificate_application SET application_status = 'approved' WHERE application_id = 1002;
SELECT * FROM certificate_application
WHERE application_id = 1002;
-- Task 2
START TRANSACTION;
UPDATE certificate_application SET application_status = 'approved',purpose = 'welfare scheme certificate' WHERE application_id = 1002;
COMMIT;
SELECT * FROM certificate_application WHERE application_id = 1002;
-- Task 3
START TRANSACTION;
UPDATE certificate_application SET application_status = 'rejected',purpose = 'incorrectly rejected' WHERE application_id = 1002;
SELECT * FROM certificate_application WHERE application_id = 1002;
ROLLBACK;
SELECT * FROM certificate_application WHERE application_id = 1002;
-- Task 4
START TRANSACTION;
INSERT INTO certificate_application(application_id, citizen_id, application_date, purpose, application_status, fee_paid, reference_number, certificate_id, office_id)
VALUES
(1006, 106, '2026-07-08', 'residence certificate', 'pending', 100.00, 'gp20260006', 1, 1);

SELECT * FROM certificate_application
WHERE application_id = 1006;

ROLLBACK;

SELECT * FROM certificate_application
WHERE application_id = 1006;
-- Task 5
START TRANSACTION;
DELETE FROM certificate_application
WHERE application_id = 1002;

SELECT * FROM certificate_application
WHERE application_id = 1002;

ROLLBACK;

SELECT * FROM certificate_application
WHERE application_id = 1002;
-- Task 6
START TRANSACTION;
UPDATE certificate_application
SET application_status = 'approved'
WHERE application_id = 1001;
UPDATE certificate_application
SET purpose = 'residence certificate'
WHERE application_id = 1002;
COMMIT;
SELECT * FROM certificate_application
WHERE application_id IN (1001,1002);
-- Task 1
START TRANSACTION;
UPDATE certificate_application
SET application_status = 'approved'
WHERE application_id = 1001;
SAVEPOINT application_update;
UPDATE certificate_application
SET application_status = 'rejected'
WHERE application_id = 1002;
ROLLBACK TO SAVEPOINT application_update;
SELECT * FROM certificate_application
WHERE application_id IN (1001,1002);
COMMIT;
-- Task 2
START TRANSACTION;
INSERT INTO certificate_application
(application_id, citizen_id, application_date, purpose, application_status, fee_paid, reference_number, certificate_id, office_id)
VALUES
(1003, 101, '2026-07-08', 'residence certificate', 'pending', 100.00, 'REF1003', 1, 1);

SAVEPOINT application_insert;
UPDATE certificate_application
SET application_status = 'rejected'
WHERE application_id = 1002;
ROLLBACK TO SAVEPOINT application_insert;
COMMIT;
SELECT * FROM certificate_application
WHERE application_id IN (1002,1003);
-- Task 3
START TRANSACTION;
UPDATE certificate_application
SET application_status = 'approved'
WHERE application_id = 1001;
SAVEPOINT first_update;
UPDATE certificate_application
SET application_status = 'rejected'
WHERE application_id = 1002;
SAVEPOINT second_update;
UPDATE certificate_application
SET purpose = 'incorrect purpose'
WHERE application_id = 1001;
ROLLBACK TO SAVEPOINT first_update;
COMMIT;
SELECT * FROM certificate_application WHERE application_id IN (1001,1002);
-- Task 4
START TRANSACTION;
INSERT INTO certificate_application
(application_id, citizen_id, application_date, purpose, application_status, fee_paid, reference_number, certificate_id, office_id)
VALUES
(1004, 101, '2026-07-08', 'residence certificate', 'pending', 100.00, 'REF1004', 1, 1);
UPDATE certificate_application
SET application_status = 'approved'
WHERE application_id = 1001;
SAVEPOINT valid_changes;
DELETE FROM certificate_application
WHERE application_id = 1002;
ROLLBACK TO SAVEPOINT valid_changes;
COMMIT;
SELECT * FROM certificate_application
WHERE application_id IN (1001,1002,1004);
-- Task 5
START TRANSACTION;
SAVEPOINT test_savepoint;
UPDATE certificate_application
SET application_status = 'approved'
WHERE application_id = 1001;
RELEASE SAVEPOINT test_savepoint;
ROLLBACK TO SAVEPOINT test_savepoint;
-- Task 6
START TRANSACTION;
UPDATE certificate_application
SET application_status = 'approved'
WHERE application_id = 1001;
SAVEPOINT application_savepoint;
UPDATE certificate_application
SET application_status = 'rejected'
WHERE application_id = 1002;
ROLLBACK TO SAVEPOINT application_savepoint;
COMMIT;
SELECT * FROM certificate_application
WHERE application_id IN (1001,1002);
-- Task 1
DROP USER IF EXISTS 'clerk1'@'localhost';
CREATE USER 'clerk1'@'localhost'
IDENTIFIED BY 'Clerk@123';
SELECT User, Host
FROM mysql.user
WHERE User = 'clerk1';
-- Task 2
GRANT SELECT
ON gram_panchayat.certificate_application
TO 'clerk1'@'localhost';
SHOW GRANTS FOR 'clerk1'@'localhost';
-- Task 3
GRANT INSERT
ON gram_panchayat.certificate_application
TO 'clerk1'@'localhost';
SHOW GRANTS FOR 'clerk1'@'localhost';
-- Task 4
SHOW GRANTS FOR 'clerk1'@'localhost';
-- Task 5
GRANT SELECT
ON gram_panchayat.Approved_Applications
TO 'clerk1'@'localhost';
SHOW GRANTS FOR 'clerk1'@'localhost';
-- Task 6
REVOKE INSERT
ON gram_panchayat.certificate_application
FROM 'clerk1'@'localhost';
SHOW GRANTS FOR 'clerk1'@'localhost';
-- Task 1
DROP USER IF EXISTS 'clerk1'@'localhost';
CREATE USER 'clerk1'@'localhost'
IDENTIFIED BY 'Clerk@123';
GRANT SELECT, INSERT
ON gram_panchayat.certificate_application
TO 'clerk1'@'localhost';
SHOW GRANTS FOR 'clerk1'@'localhost';
-- Task 2
DROP USER IF EXISTS 'officer1'@'localhost';
CREATE USER 'officer1'@'localhost'
IDENTIFIED BY 'Officer@123';
GRANT SELECT, INSERT, UPDATE
ON gram_panchayat.certificate_application
TO 'officer1'@'localhost';
SHOW GRANTS FOR 'officer1'@'localhost';
-- Task 3
GRANT SELECT
ON gram_panchayat.Approved_Applications
TO 'officer1'@'localhost';
SELECT * FROM Approved_Applications;
-- Task 4
GRANT SELECT, INSERT, UPDATE
ON gram_panchayat.certificate_application
TO 'officer1'@'localhost';
REVOKE UPDATE
ON gram_panchayat.certificate_application
FROM 'officer1'@'localhost';
SHOW GRANTS FOR 'officer1'@'localhost';
-- Task 5
SHOW GRANTS FOR 'clerk1'@'localhost';
SHOW GRANTS FOR 'officer1'@'localhost';
-- Task 6
DROP USER IF EXISTS 'clerk1'@'localhost';
CREATE USER 'clerk1'@'localhost'
IDENTIFIED BY 'Clerk@123';
GRANT SELECT, INSERT
ON gram_panchayat.certificate_application
TO 'clerk1'@'localhost';
SHOW GRANTS FOR 'clerk1'@'localhost';
-- Task 1
START TRANSACTION;
INSERT INTO certificate_application
(application_id, citizen_id, application_date, purpose, application_status, fee_paid, reference_number, certificate_id, office_id)
VALUES
(1005, 101, '2026-07-08', 'residence certificate', 'pending', 100.00, 'REF1005', 1, 1);
SELECT * FROM certificate_application
WHERE application_id = 1005;

COMMIT;
-- Task 2
START TRANSACTION;
UPDATE certificate_application
SET application_status = 'rejected',
    purpose = 'incorrectly rejected'
WHERE application_id = 1002;

SELECT * FROM certificate_application
WHERE application_id = 1002;
ROLLBACK;
SELECT * FROM certificate_application
WHERE application_id = 1002;
-- Task 3
START TRANSACTION;
UPDATE certificate_application
SET application_status = 'approved'
WHERE application_id = 1001;
SAVEPOINT valid_update;
UPDATE certificate_application
SET application_status = 'rejected'
WHERE application_id = 1002;
ROLLBACK TO SAVEPOINT valid_update;
COMMIT;
SELECT * FROM certificate_application
WHERE application_id IN (1001,1002);
-- Task 4
DROP USER IF EXISTS 'clerk1'@'localhost';
CREATE USER 'clerk1'@'localhost'
IDENTIFIED BY 'Clerk@123';
GRANT SELECT, INSERT
ON gram_panchayat.certificate_application
TO 'clerk1'@'localhost';
SHOW GRANTS FOR 'clerk1'@'localhost';
-- Task 5
GRANT SELECT
ON gram_panchayat.Approved_Applications
TO 'clerk1'@'localhost';
SHOW GRANTS FOR 'clerk1'@'localhost';
-- Task 6
REVOKE INSERT
ON gram_panchayat.certificate_application
FROM 'clerk1'@'localhost';
SHOW GRANTS FOR 'clerk1'@'localhost';
USE gram_panchayat;

SHOW TABLES;

SELECT * FROM certificate_application;
SELECT @@AUTOCOMMIT;
SET AUTOCOMMIT = 1;
SELECT CURRENT_USER();
SHOW GRANTS FOR 'clerk1'@'localhost';