-- Create Database
CREATE DATABASE ResortManagement;
USE ResortManagement;
-- 1. LOGIN
CREATE TABLE LOGIN (
 login_id INT AUTO_INCREMENT PRIMARY KEY,
 username VARCHAR(100) NOT NULL UNIQUE CHECK (username LIKE '%@%.%'),
 password VARCHAR(100) NOT NULL
);
-- 2. BANK
CREATE TABLE BANK (
 bank_id INT AUTO_INCREMENT PRIMARY KEY,
 name VARCHAR(20) NOT NULL,
 city VARCHAR(20) NOT NULL,
 country VARCHAR(20) NOT NULL,
 house_no VARCHAR(20) NOT NULL,
 street_no VARCHAR(20) NOT NULL,
 area VARCHAR(20) NOT NULL
);
-- 3. BANK_ACCOUNT
CREATE TABLE BANK_ACCOUNT (
 bank_account_id INT AUTO_INCREMENT PRIMARY KEY,
 bank_id INT NOT NULL,
 balance DECIMAL(10,2) NOT NULL,
 FOREIGN KEY (bank_id) REFERENCES BANK(bank_id)
);
-- 4. EMPLOYEE_TYPE
CREATE TABLE EMPLOYEE_TYPE (
 employee_type_id INT AUTO_INCREMENT PRIMARY KEY,
 designation VARCHAR(20) NOT NULL,
 min_salary INT NOT NULL,
 max_salary INT NOT NULL
);
-- 5. EMPLOYEE
CREATE TABLE EMPLOYEE (
 employee_id INT AUTO_INCREMENT PRIMARY KEY,
 first_name VARCHAR(20) NOT NULL,
 last_name VARCHAR(20) NOT NULL,
 city VARCHAR(20) NOT NULL,
 country VARCHAR(20) NOT NULL,
 house_no VARCHAR(20) NOT NULL,
 street_no VARCHAR(20) NOT NULL,
 area VARCHAR(20) NOT NULL,
 employee_type_id INT NOT NULL,
 login_id INT NOT NULL,
 salary INT NOT NULL CHECK (salary > 0),
 account_id INT NOT NULL,
 FOREIGN KEY (employee_type_id) REFERENCES 
EMPLOYEE_TYPE(employee_type_id),
 FOREIGN KEY (login_id) REFERENCES LOGIN(login_id),
 FOREIGN KEY (account_id) REFERENCES BANK_ACCOUNT(bank_account_id)
);
-- 6. EMPLOYEE_CONTACT_INFO
CREATE TABLE EMPLOYEE_CONTACT_INFO (
 employee_id INT,
 phone_number BIGINT,
 FOREIGN KEY (employee_id) REFERENCES EMPLOYEE(employee_id)
);
-- 7. FOOD_ITEM
CREATE TABLE FOOD_ITEM (
 food_item_id INT AUTO_INCREMENT PRIMARY KEY,
 food_item_name VARCHAR(20) NOT NULL,
 description VARCHAR(20) NOT NULL,
 per_item_price DECIMAL(10,2) NOT NULL,
 quantity_available INT NOT NULL
);
-- 8. FOOD_ITEM_EMPLOYEE
CREATE TABLE FOOD_ITEM_EMPLOYEE (
 employee_id INT NOT NULL,
 food_item_id INT NOT NULL,
 FOREIGN KEY (employee_id) REFERENCES EMPLOYEE(employee_id),
 FOREIGN KEY (food_item_id) REFERENCES FOOD_ITEM(food_item_id)
);
-- 9. FOOD_MENU
CREATE TABLE FOOD_MENU (
 food_menu_id INT AUTO_INCREMENT PRIMARY KEY,
 employee_id INT NOT NULL,
 FOREIGN KEY (employee_id) REFERENCES EMPLOYEE(employee_id)
);
-- 10. JOB_HISTORY
CREATE TABLE JOB_HISTORY (
 employee_id INT NOT NULL,
 start_date DATE NOT NULL,
 employee_type_id INT NOT NULL,
 end_date DATE NOT NULL,
 PRIMARY KEY (employee_id, start_date),
 FOREIGN KEY (employee_id) REFERENCES EMPLOYEE(employee_id),
 FOREIGN KEY (employee_type_id) REFERENCES 
EMPLOYEE_TYPE(employee_type_id)
);
-- 11. GODOWN
CREATE TABLE GODOWN (
 godown_id INT AUTO_INCREMENT PRIMARY KEY,
 godown_name VARCHAR(20) NOT NULL,
 employee_id INT NOT NULL,
 FOREIGN KEY (employee_id) REFERENCES EMPLOYEE(employee_id)
);
-- 12. FOOD_MENU_ITEM
CREATE TABLE FOOD_MENU_ITEM (
 food_menu_id INT NOT NULL,
 food_item_id INT NOT NULL,
 FOREIGN KEY (food_menu_id) REFERENCES FOOD_MENU(food_menu_id),
 FOREIGN KEY (food_item_id) REFERENCES FOOD_ITEM(food_item_id)
);
-- 13. SERVICE
CREATE TABLE SERVICE (
 service_id INT AUTO_INCREMENT PRIMARY KEY,
 service_name VARCHAR(20) NOT NULL,
 service_cost DECIMAL(10,2) NOT NULL
);
-- 14. GUEST
CREATE TABLE GUEST (
 guestid INT AUTO_INCREMENT PRIMARY KEY,
 cnic VARCHAR(20) NOT NULL,
 first_name VARCHAR(20) NOT NULL,
 last_name VARCHAR(20) NOT NULL,
 phone_no BIGINT NOT NULL,
 email VARCHAR(30) NOT NULL,
 city VARCHAR(20) NOT NULL,
 country VARCHAR(20) NOT NULL,
 house_no VARCHAR(20) NOT NULL,
 street_no VARCHAR(20) NOT NULL,
 area VARCHAR(20) NOT NULL,
 driving_licence ENUM('Y','N') NOT NULL,
 gender ENUM('M','F') NOT NULL DEFAULT 'M'
);
-- 15. VEHICLE_TYPE
CREATE TABLE VEHICLE_TYPE (
 vehicle_type_id INT AUTO_INCREMENT PRIMARY KEY,
 vehicle_type_name VARCHAR(20) NOT NULL
);
-- 16. PARKING_AREA
CREATE TABLE PARKING_AREA (
 parking_id INT AUTO_INCREMENT PRIMARY KEY,
 vehicle_type_id INT NOT NULL,
 guest_id INT NOT NULL,
 parking_status ENUM('P','N') NOT NULL DEFAULT 'N',
 FOREIGN KEY (vehicle_type_id) REFERENCES VEHICLE_TYPE(vehicle_type_id),
 FOREIGN KEY (guest_id) REFERENCES GUEST(guestid)
);
-- 17. ROOMSTATUS
CREATE TABLE ROOMSTATUS (
 roomstatus_id INT AUTO_INCREMENT PRIMARY KEY,
 roomstatus VARCHAR(20) NOT NULL
);
-- 18. ROOMTYPE
CREATE TABLE ROOMTYPE (
 roomtype_id INT AUTO_INCREMENT PRIMARY KEY,
 roomtype_name VARCHAR(20) NOT NULL,
 rates DECIMAL(10,2) NOT NULL,
 capacity INT NOT NULL DEFAULT 5
);
-- 19. ROOM
CREATE TABLE ROOM (
 room_id INT AUTO_INCREMENT PRIMARY KEY,
 roomstatus_id INT NOT NULL,
 roomtype_id INT NOT NULL,
 roomlocation INT NOT NULL,
 FOREIGN KEY (roomstatus_id) REFERENCES ROOMSTATUS(roomstatus_id),
 FOREIGN KEY (roomtype_id) REFERENCES ROOMTYPE(roomtype_id)
);
-- 20. RESERVATION
CREATE TABLE RESERVATION (
 reservation_id INT AUTO_INCREMENT PRIMARY KEY,
 guest_id INT NOT NULL,
 room_id INT NOT NULL,
 reservation_date DATE NOT NULL,
 check_in_date DATE NOT NULL,
 check_out_date DATE NOT NULL,
 status VARCHAR(20),
 adult INT NOT NULL,
 children INT NOT NULL,
 FOREIGN KEY (guest_id) REFERENCES GUEST(guestid),
 FOREIGN KEY (room_id) REFERENCES ROOM(room_id)
);
-- 21. PAYMENT_TYPE
CREATE TABLE PAYMENT_TYPE (
 payment_type_id INT AUTO_INCREMENT PRIMARY KEY,
 payment_type_name VARCHAR(20) NOT NULL
);
-- 22. RESERVATION_BILL
CREATE TABLE RESERVATION_BILL (
 reservation_bill_id INT AUTO_INCREMENT PRIMARY KEY,
 payment_amount DECIMAL(10,2) NOT NULL,
 guest_id INT NOT NULL,
 payment_date DATE NOT NULL,
 payment_type_id INT NOT NULL,
 account_id INT NOT NULL,
 FOREIGN KEY (guest_id) REFERENCES GUEST(guestid),
 FOREIGN KEY (payment_type_id) REFERENCES 
PAYMENT_TYPE(payment_type_id),
 FOREIGN KEY (account_id) REFERENCES BANK_ACCOUNT(bank_account_id)
);
-- 23. RESORT_EXPENSE
CREATE TABLE HOTEL_EXPENSE (
 expense_id INT AUTO_INCREMENT PRIMARY KEY,
 expense_name VARCHAR(20) NOT NULL,
 expense_cost DECIMAL(10,2) NOT NULL,
 description VARCHAR(200),
 bank_account_id INT NOT NULL,
 payment_date DATE NOT NULL,
 FOREIGN KEY (bank_account_id) REFERENCES 
BANK_ACCOUNT(bank_account_id)
);
-- 24. INVENTORY
CREATE TABLE INVENTORY (
 inventory_id INT AUTO_INCREMENT PRIMARY KEY,
 inventory_name VARCHAR(20) NOT NULL,
 quantity INT NOT NULL,
 godown_id INT NOT NULL,
 employee_id INT NOT NULL,
 FOREIGN KEY (godown_id) REFERENCES GODOWN(godown_id),
 FOREIGN KEY (employee_id) REFERENCES EMPLOYEE(employee_id)
);
-- 25. PRODUCT
CREATE TABLE PRODUCT (
 product_id INT AUTO_INCREMENT PRIMARY KEY,
 product_name VARCHAR(20) NOT NULL,
 barcode BIGINT NOT NULL,
 description VARCHAR(20) NOT NULL
);
-- 26. PRODUCT_IN_GODOWN
CREATE TABLE PRODUCT_IN_GODOWN (
 product_id INT NOT NULL,
 godown_id INT NOT NULL,
 FOREIGN KEY (product_id) REFERENCES PRODUCT(product_id),
 FOREIGN KEY (godown_id) REFERENCES GODOWN(godown_id)
);
-- 27. PRODUCT_IN_INVENTORY
CREATE TABLE PRODUCT_IN_INVENTORY (
 product_id INT NOT NULL,
 inventory_id INT NOT NULL,
 FOREIGN KEY (product_id) REFERENCES PRODUCT(product_id),
 FOREIGN KEY (inventory_id) REFERENCES INVENTORY(inventory_id)
);
-- 28. SUPPLIER
CREATE TABLE SUPPLIER (
 supplier_id INT AUTO_INCREMENT PRIMARY KEY,
 supplier_name VARCHAR(20) NOT NULL,
 reg_no BIGINT NOT NULL,
 cnic VARCHAR(20) NOT NULL,
 city VARCHAR(20) NOT NULL,
 country VARCHAR(20) NOT NULL,
 house_no VARCHAR(20) NOT NULL,
 street_no VARCHAR(20) NOT NULL,
 area VARCHAR(20) NOT NULL
);
-- 29. SUPPLIER_PRODUCT
CREATE TABLE SUPPLIER_PRODUCT (
 supplier_id INT NOT NULL,
 product_id INT NOT NULL,
 date_supplied DATE NOT NULL,
 FOREIGN KEY (supplier_id) REFERENCES SUPPLIER(supplier_id),
 FOREIGN KEY (product_id) REFERENCES PRODUCT(product_id)
);
-- 30. SHIPMENT
CREATE TABLE SHIPMENT (
 shipment_no INT AUTO_INCREMENT PRIMARY KEY,
 shipment_date DATE NOT NULL,
 serial_no BIGINT NOT NULL,
 city VARCHAR(20) NOT NULL,
 country VARCHAR(20) NOT NULL,
 house_no VARCHAR(20) NOT NULL,
 street_no VARCHAR(20) NOT NULL,
 area VARCHAR(20) NOT NULL,
 supplier_id INT NOT NULL,
 FOREIGN KEY (supplier_id) REFERENCES SUPPLIER(supplier_id)
);
-- 31. PRODUCT_SHIPMENT
CREATE TABLE PRODUCT_SHIPMENT (
 product_id INT NOT NULL,
 shipment_id INT NOT NULL,
 FOREIGN KEY (product_id) REFERENCES PRODUCT(product_id),
 FOREIGN KEY (shipment_id) REFERENCES SHIPMENT(shipment_no)
);
-- 32. FOOD_ORDER
CREATE TABLE FOOD_ORDER (
 food_order_id INT AUTO_INCREMENT PRIMARY KEY,
 food_item_id INT NOT NULL,
 guest_id INT NOT NULL,
 quantity_ordered INT NOT NULL,
 FOREIGN KEY (food_item_id) REFERENCES FOOD_ITEM(food_item_id),
 FOREIGN KEY (guest_id) REFERENCES GUEST(guestid)
);
-- 33. EMPLOYEE_SERVE_GUEST
CREATE TABLE EMPLOYEE_SERVE_GUEST (
 service_id INT,
 guest_id INT,
 employee_id INT,
 FOREIGN KEY (employee_id) REFERENCES EMPLOYEE(employee_id),
 FOREIGN KEY (guest_id) REFERENCES GUEST(guestid),
 FOREIGN KEY (service_id) REFERENCES SERVICE(service_id)
);
-- 1. LOGIN
INSERT INTO LOGIN (login_id, username, password) VALUES
(1, 'amnabajwa@gmail.com', '03347456044'),
(2, 'mahammaqbool@gmail.com', 'maham12'),
(3, 'Sameerkatija@gmail.com', 'sameer2000'),
(4, 'Humayaseen@gmail.com', 'huma21'),
(5, 'Sahilarwand21@gmail.com', 'sahilarwand23'),
(6, 'Hasnainraza@gmail.com', 'hasnainraza43'),
(7, 'Basitmajeed@gmail.com', 'basit54'),
(8, 'Adilali@gmail.com', 'adilali'),
(9, 'saradhilon@gmail.com', 'sara12'),
(10, 'Aniqanaveen@gmail.com', 'neeno'),
(11, 'Hammadfarooq@gmail.com', 'hamtaro'),
(12, 'Usmanwarriach@gmail.com', 'Osman12'),
(13, 'DaniaSadaf@gmail.com', 'Sadaf12'),
(14, 'AroosaSultan12@gmail.com', 'Sultan12'),
(15, 'Danishahmad@gmail.com', 'Danishwer'),
(16, 'Talhayounas@gmail.com', 'younas1');
-- 2. BANK
INSERT INTO BANK (bank_id, name, city, country, house_no, street_no, area) 
VALUES
(1, 'Al Baraka Bank', 'Lahore', 'Pakistan', '142', 'J1', 'Wapdatown'),
(2, 'Allied Bank', 'Lahore', 'Pakistan', '9', 'H1', 'Askari_9'),
(3, 'Askari Bank', 'Lahore', 'Pakistan', '14', 'defence 8', 'cantt'),
(4, 'Askari Islamic Bank', 'Lahore', 'Pakistan', '2', 'j2', 'wapdatown'),
(5, 'Bank Alfallah', 'Lahore', 'Pakistan', '4', 'J1', 'Wapdatown'),
(6, 'Bank Al-Habib', 'Lahore', 'Pakistan', '6', 'K3', 'Gulshan-e-Lahore'),
(7, 'Citi Bank', 'Karachi', 'Pakistan', '23', 'K1', 'Johar Town'),
(8, 'Faysal Bank', 'Lahore', 'Pakistan', '15', 'H1', 'Wapdatown'),
(9, 'Habib Bank', 'Lahore', 'Pakistan', '12', 'J1', 'Johar Town'),
(10, 'JS Bank', 'Lahore', 'Pakistan', '152', 'J2', 'Defence'),
(11, 'MCB Bank', 'Lahore', 'Pakistan', '23', 'G4', 'Wapdatown'),
(12, 'Allied Bank', 'Lahore', 'Pakistan', '101', 'G11', 'Gulshan-e-Lahore'),
(13, 'Bank Al-Habib', 'Lahore', 'Pakistan', '56', 'J2', 'Wapdatown'),
(14, 'Al Baraka Bank', 'Karachi', 'Pakistan', '43', '234J', 'Model Town'),
(15, 'Askari Bank', 'Peshawar', 'Pakistan', '234', 'TH1', 'Samnabad'),
(16, 'Bank Alfallah', 'Islamabad', 'Pakistan', '38', 'E2', 'Cantt');
-- 3. BANK_ACCOUNT
INSERT INTO BANK_ACCOUNT (bank_account_id, bank_id, balance) VALUES
(1, 1, 50000.00),
(2, 2, 55000.00),
(3, 3, 89000.00),
(4, 4, 70000.00),
(5, 5, 10000.00),
(6, 5, 40000.00),
(7, 7, 15000.00),
(8, 8, 30000.00),
(9, 9, 45000.00),
(10, 10, 90000.00),
(11, 11, 45000.00),
(12, 12, 35000.00),
(13, 13, 50000.00),
(14, 14, 60000.00),
(15, 15, 70000.00),
(16, 16, 65000.00);
-- 4. EMPLOYEE_TYPE
INSERT INTO EMPLOYEE_TYPE (employee_type_id, designation, min_salary, 
max_salary) VALUES
(1, 'Manager', 50000, 100000),
(2, 'Chef', 30000, 80000),
(3, 'Waiter', 25000, 50000),
(4, 'Receptionist', 20000, 40000),
(5, 'Guard', 20000, 35000),
(6, 'Sweeper', 10000, 30000),
(7, 'Chef', 30000, 80000),
(8, 'Waitress', 25000, 50000),
(9, 'Clerk', 15000, 30000),
(10, 'Guard', 20000, 35000),
(11, 'Worker', 10000, 20000),
(12, 'Tour Guide', 10000, 20000),
(13, 'Hotel Service', 10000, 20000);
-- 5. EMPLOYEE (All 16 records)
INSERT INTO EMPLOYEE (employee_id, first_name, last_name, city, country, 
house_no, street_no, area, employee_type_id, login_id, salary, account_id) 
VALUES
(1, 'Amna', 'Bajwa', 'Lahore', 'Pakistan', '142', 'J1', 'Wapdatown', 1, 1, 80000, 1),
(2, 'Maham', 'Maqbool', 'Lahore', 'Pakistan', '9', 'H1', 'Askari_9', 2, 2, 40000, 2),
(3, 'Sameer', 'Katija', 'Lahore', 'Pakistan', '14', 'Defence 8', 'Cantt', 3, 3, 30000, 3),
(4, 'Huma', 'Yaseen', 'Lahore', 'Pakistan', '2', 'J2', 'Wapdatown', 4, 4, 30000, 4),
(5, 'Sahil', 'Arwand', 'Lahore', 'Pakistan', '4', 'J1', 'Wapdatown', 5, 5, 25000, 5),
(6, 'Hasnain', 'Raza', 'Lahore', 'Pakistan', '6', 'K3', 'Gulshan-e-Lahore', 6, 6, 20000, 
6),
(7, 'Basit', 'Majeed', 'Karachi', 'Pakistan', '23', 'K1', 'Johar Town', 7, 7, 50000, 7),
(8, 'Adil', 'Ali', 'Lahore', 'Pakistan', '15', 'H1', 'Wapdatown', 8, 8, 30000, 8),
(9, 'Sara', 'Dhilon', 'Lahore', 'Pakistan', '12', 'J1', 'Johar Town', 9, 9, 25000, 9),
(10, 'Aniqa', 'Naveen', 'Lahore', 'Pakistan', '152', 'J2', 'Defence', 10, 10, 25000, 10),
(11, 'Hammad', 'Farooq', 'Lahore', 'Pakistan', '23', 'G4', 'Wapdatown', 11, 11, 
15000, 11),
(12, 'Usman', 'Warraich', 'Lahore', 'Pakistan', '101', 'G11', 'Gulshan-e-Lahore', 11, 
12, 15000, 12),
(13, 'Dania', 'Sadaf', 'Lahore', 'Pakistan', '27', '1J2', 'Wapdatown', 11, 13, 15000, 
13),
(14, 'Aroosa', 'Sultan', 'Lahore', 'Pakistan', '34', '1J1', 'Wapdatown', 12, 14, 18000, 
14),
(15, 'Danish', 'Ahmad', 'Kasoor', 'Pakistan', '34', 'Chak-65', 'Moorwala', 13, 15, 
12000, 15),
(16, 'Talha', 'Younas', 'Faisalabad', 'Pakistan', '34', 'GT-Road', 'Ghanta Ghar', 13, 
16, 15000, 16);
-- 6. EMPLOYEE_CONTACT_INFO (All 17 phone numbers)
INSERT INTO EMPLOYEE_CONTACT_INFO (employee_id, phone_number) VALUES
(1, 03347456044),
(2, 03377274848),
(3, 03317133969),
(4, 03165429882),
(5, 03404625365),
(6, 03056598539),
(7, 03017100731),
(8, 03344324618),
(9, 03083353253),
(10, 03110678166),
(11, 03126473594),
(12, 03442682638),
(13, 03117463846),
(14, 03128573070),
(15, 03374394073),
(16, 03213989763),
(1, 03356860237);
-- 7. FOOD_ITEM (All 15 items)
INSERT INTO FOOD_ITEM (food_item_id, food_item_name, description, 
per_item_price, quantity_available) VALUES
(1, 'Bread', 'breakfast', 100.00, 10),
(2, 'Oatmeal', 'breakfast', 120.00, 10),
(3, 'Cereal', 'breakfast', 130.00, 10),
(4, 'Milk', 'breakfast/Regular', 65.00, 10),
(5, 'Chicken Karahi', 'for Desi lunch', 520.00, 10),
(6, 'Chicken Biryani', 'for Desi Lunch', 380.00, 10),
(7, 'Pulao', 'for Desi Lunch', 250.00, 10),
(8, 'Chicken Manchurian', 'Continental', 480.00, 10),
(9, 'Fish and Chips', 'Dinner', 260.00, 10),
(10, 'Plain Rice', 'Dinner', 160.00, 10),
(11, 'Steak', 'have many types', 780.00, 10),
(12, 'Coke', 'Beverages', 65.00, 100),
(13, 'Sprite', 'Beverages', 65.00, 100),
(14, 'Fanta', 'Beverages', 65.00, 100),
(15, 'Water', 'Nestle Water', 65.00, 100);
-- 8. FOOD_ITEM_EMPLOYEE(All 15 relationships)
INSERT INTO FOOD_ITEM_EMPLOYEE (employee_id, food_item_id) VALUES
(2, 1),
(7, 2),
(2, 3),
(7, 4),
(2, 5),
(7, 6),
(2, 7),
(7, 8),
(2, 9),
(7, 10),
(2, 11),
(7, 12),
(2, 13),
(7, 14),
(2, 15);
-- 9. FOOD_MENU (All 10 menus)
INSERT INTO FOOD_MENU (food_menu_id, employee_id) VALUES
(1, 3),
(2, 8),
(3, 3),
(4, 3),
(5, 8),
(6, 8),
(7, 8),
(8, 8),
(9, 3),
(10, 3);
-- 10. JOB_HISTORY (All 16 records)
INSERT INTO JOB_HISTORY (employee_id, start_date, employee_type_id, 
end_date) VALUES
(1, '2018-07-05', 1, '2019-07-06'),
(2, '2018-06-10', 2, '2019-06-10'),
(3, '2018-07-05', 3, '2019-07-06'),
(4, '2018-09-05', 4, '2019-09-10'),
(5, '2018-04-02', 5, '2019-07-06'),
(6, '2018-03-21', 6, '2019-03-21'),
(7, '2018-01-19', 7, '2019-01-19'),
(8, '2018-02-27', 8, '2019-02-27'),
(9, '2018-08-24', 9, '2019-07-24'),
(10, '2018-07-15', 10, '2019-07-06'),
(11, '2018-01-12', 11, '2019-01-12'),
(12, '2018-05-20', 11, '2019-05-20'),
(13, '2018-10-24', 11, '2019-10-24'),
(14, '2018-11-01', 12, '2019-11-01'),
(15, '2018-12-07', 13, '2019-12-02'),
(16, '2018-03-24', 13, '2019-03-24');
-- 11. GODOWN (All 10 records)
INSERT INTO GODOWN (godown_id, godown_name, employee_id) VALUES
(1, 'A', 11),
(2, 'B', 12),
(3, 'C', 13),
(4, 'D', 11),
(5, 'E', 12),
(6, 'F', 13),
(7, 'G', 11),
(8, 'H', 12),
(9, 'I', 13),
(10, 'J', 11);
-- 12. FOOD_MENU_ITEM (All 11 relationships)
INSERT INTO FOOD_MENU_ITEM (food_menu_id, food_item_id) VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(9,9),
(10,10),
(9,1);
-- 13. SERVICE (All 9 services)
INSERT INTO SERVICE (service_id, service_name, service_cost) VALUES
(1, 'Baby Sitting', 5000.00),
(2, 'Laundry', 2500.00),
(3, 'Ironing', 2000.00),
(4, 'Food Services', 1000.00),
(5, 'Tour Services', 6000.00),
(6, 'Gym', 3000.00),
(7, 'Swimming', 5000.00),
(8, 'Spa Packages', 7000.00),
(9, 'Room Upgrade', 2000.00);
-- 14. GUEST (All 10 guests)
INSERT INTO GUEST (guestid, cnic, first_name, last_name, phone_no, email, city, 
country, house_no, street_no, area, driving_licence, gender) VALUES
(1, '34603-621430-3', 'Tayyaba', 'Mahmood', 3356860237, 
'tayyabmahmood50@gmail.com', 'Lahore', 'Pakistan', '142', 'J1', 'Wapdatown', 'Y', 
'F'),
(2, '32457-223150-8', 'Mahmood', 'Bajwa', 3317796642, 
'mahmoodbajwa50@gmail.com', 'Lahore', 'Pakistan', '142', 'J1', 'Wapdatown', 'Y', 
'M'),
(3, '33613-611450-2', 'Waqas', 'Bajwa', 3430755862, 
'waqasbajwa722@hotmail.com', 'Lahore', 'Pakistan', '142', 'J1', 'Wapdatown', 'Y', 
'M'),
(4, '33305-662122-0', 'Sehar', 'Bajwa', 3343260237, 'Hani_sehar@gmail.com', 
'Lahore', 'Pakistan', '142', 'J1', 'Wapdatown', 'N', 'F'),
(5, '34502-521230-4', 'Ayesha', 'Bajwa', 3425632527, 'ayesha_pinky@gmail.com', 
'Lahore', 'Pakistan', '142', 'J1', 'Wapdatown', 'N', 'F'),
(6, '33205-221133-0', 'Sundus', 'Bajwa', 3317134044, 'suna_suni@gmail.com', 
'Lahore', 'Pakistan', '142', 'J1', 'Wapdatown', 'N', 'F'),
(7, '32615-463432-0', 'Samina', 'Qamar', 3054380818, 
'saminaqamar21@gmail.com', 'Lahore', 'Pakistan', '101', 'G11', 'Gulshan-e￾Lahore', 'N', 'F'),
(8, '33625-423372-9', 'Qamar', 'Raiz', 3004848270, 'qamarraiz50@gmail.com', 
'Lahore', 'Pakistan', '101', 'G11', 'Gulshan-e-Lahore', 'N', 'M'),
(9, '33315-6224552-9', 'Rehman', 'Haider', 3247733400, 
'rehman_haider19@gmail.com', 'Lahore', 'Pakistan', '101', 'G11', 'Gulshan-e￾Lahore', 'N', 'M'),
(10, '32205-699040-0', 'Sanabil', 'Shahid', 3314951675, 
'sanabilshahdi20@gmail.com', 'Lahore', 'Pakistan', '71', 'H1', 'Wapdatown', 'Y', 'F');
-- 15. VEHICLE_TYPE (All 11 types)
INSERT INTO VEHICLE_TYPE (vehicle_type_id, vehicle_type_name) VALUES
(1, 'Motor Bike'),
(2, 'Scooter'),
(3, 'Civic'),
(4, 'Honda'),
(5, 'Corolla'),
(6, 'Mehran Suzuki'),
(7, 'Parado'),
(8, 'Wagon R'),
(9, 'Land Cruiser'),
(10, 'Lamborgini'),
(11, 'Audi');
-- 16. PARKING_AREA (All 10 records)
INSERT INTO PARKING_AREA (parking_id, vehicle_type_id, guest_id, 
parking_status) VALUES
(1,5,1,'P'),
(2,5,2,'P'),
(3,11,3,'P'),
(4,7,4,'P'),
(5,10,5,'P'),
(6,11,6,'P'),
(7,4,7,'N'),
(8,4,8,'P'),
(9,1,9,'P'),
(10,6,10,'P');
-- 17. ROOMSTATUS (3 statuses)
INSERT INTO ROOMSTATUS (roomstatus_id, roomstatus) VALUES
(1, 'Empty'),
(2, 'Filled'),
(3, 'Closed');
-- 18. ROOMTYPE (4 types)
INSERT INTO ROOMTYPE (roomtype_id, roomtype_name, rates, capacity) VALUES
(1, 'Single', 1500.00, 1),
(2, 'Double', 2000.00, 2),
(3, 'Family', 3000.00, 5),
(4, 'Suite', 5000.00, 7);
-- 19. ROOM (10 rooms)
INSERT INTO ROOM (room_id, roomstatus_id, roomtype_id, roomlocation) 
VALUES
(1,1,1,10),
(2,2,2,12),
(3,3,3,14),
(4,1,4,16),
(5,2,1,18),
(6,3,2,20),
(7,1,3,22),
(8,2,4,24),
(9,3,1,26),
(10,1,2,28);
-- 20. RESERVATION (4 reservations)
INSERT INTO RESERVATION (reservation_id, guest_id, room_id, reservation_date, 
check_in_date, check_out_date, status, adult, children) VALUES
(1,2,4,'2018-11-10','2018-11-15','2018-11-27',NULL,5,0),
(2,3,7,'2018-11-10','2018-11-15','2018-11-27',NULL,2,2),
(3,8,10,'2018-11-10','2018-11-15','2018-11-27',NULL,2,1),
(4,10,10,'2018-11-10','2018-11-15','2018-11-27',NULL,2,0);
-- 21. PAYMENT_TYPE (6 types)
INSERT INTO PAYMENT_TYPE (payment_type_id, payment_type_name) VALUES
(1, 'Credit Card'),
(2, 'Debit Card'),
(3, 'Jazz Cash'),
(4, 'Easy Paisa'),
(5, 'Online Transaction'),
(6, 'Cash');
-- 22. RESERVATION_BILL (4 bills)
INSERT INTO RESERVATION_BILL (reservation_bill_id, payment_amount, guest_id, 
payment_date, payment_type_id, account_id) VALUES
(1,60000.00,2,'2018-11-27',6,1),
(2,50000.00,3,'2018-11-27',5,1),
(3,60000.00,8,'2018-11-27',6,1),
(4,20000.00,10,'2018-11-27',6,1);
-- 23. RESORT_EXPENSE (6 expenses)
INSERT INTO HOTEL_EXPENSE (expense_id, expense_name, expense_cost, 
description, bank_account_id, payment_date) VALUES
(1,'Electricity Bill',30000.00,NULL,1,'2018-01-01'),
(2,'Water Bill',10000.00,NULL,1,'2018-01-10'),
(3,'Gas Bill',20000.00,NULL,1,'2018-01-15'),
(4,'Renovation Bill',50000.00,NULL,1,'2018-01-20'),
(5,'Security Bill',40000.00,NULL,1,'2018-01-25'),
(6,'Hotel Tax',60000.00,NULL,1,'2018-01-30');
-- 24. INVENTORY (8 inventories)
INSERT INTO INVENTORY (inventory_id, inventory_name, quantity, godown_id, 
employee_id) VALUES
(1,'Kitchen Inventory',340,1,2),
(2,'Room Inventory',450,2,11),
(3,'Electronic Inventory',240,3,12),
(4,'Staff Inventory',140,4,13),
(5,'Laundry Inventory',140,5,11),
(6,'Cleaning Inventory',140,6,12),
(7,'Common Inventory',120,7,13),
(8,'Toilet Inventory',160,8,11);
-- 25. PRODUCT (All 63 products)
INSERT INTO PRODUCT (product_id, product_name, barcode, description) VALUES
(1,'Stove',234,'Kitchen Inventory'),
(2,'Oven',235,'Kitchen Inventory'),
(3,'Boilers',236,'Kitchen Inventory'),
(4,'Pans',237,'Kitchen Inventory'),
(5,'Sink',238,'Kitchen Inventory'),
(6,'Trash',239,'Kitchen Inventory'),
(7,'Refigerators',240,'Kitchen Inventory'),
(8,'Dishes',241,'Kitchen Inventory'),
(9,'Glasses',242,'Kitchen Inventory'),
(10,'Cups',243,'Kitchen Inventory'),
(11,'Tissue Box',244,'Kitchen Inventory'),
(12,'Cabinets',300,'Room Inventory'),
(13,'Chairs',301,'Room Inventory'),
(14,'Tables',302,'Room Inventory'),
(15,'Couches',303,'Room Inventory'),
(16,'Shelves',304,'Room Inventory'),
(17,'Sofas',305,'Room Inventory'),
(18,'Lamp',306,'Room Inventory'),
(19,'Mirror',307,'Room Inventory'),
(20,'Tissuepapers',308,'Room Inventory'),
(21,'Tubelight',309,'Room Inventory'),
(22,'Bulb',310,'Room Inventory'),
(23,'Curtain',311,'Room Inventory'),
(24,'Rugs',312,'Room Inventory'),
(25,'Trash Box',313,'Room Inventory'),
(26,'TV',400,'Electronic Inventory'),
(27,'AC',401,'Electronic Inventory'),
(28,'Heator',402,'Electronic Inventory'),
(29,'Generators',403,'Electronic Inventory'),
(30,'Washing Machines',404,'Electronic Inventory'),
(31,'Electronic Meter',405,'Electronic Inventory'),
(32,'Electronic Wiring',406,'Electronic Inventory'),
(33,'Vaccum Cleaners',407,'Electronic Inventory'),
(34,'Uniforms',500,'Staff Inventory'),
(35,'Aprons',501,'Staff Inventory'),
(36,'Weapons',500,'Staff Inventory'),
(37,'Lanudry',601,'Laundry Inventory'),
(38,'Surf',500,'Staff Inventory'),
(39,'Soap',602,'Laundry Inventory'),
(40,'Bleach',603,'Laundry Inventory'),
(41,'Drier',604,'Laundry Inventory'),
(42,'Fabric Conditioner',605,'Laundry Inventory'),
(43,'Stain Remover',606,'Laundry Inventory'),
(44,'Broom',700,'Cleaning Inventory'),
(45,'Brush',701,'Cleaning Inventory'),
(46,'Soap',702,'Cleaning Inventory'),
(47,'Surf',703,'Cleaning Inventory'),
(48,'Tissue',704,'Cleaning Inventory'),
(49,'Spray',705,'Cleaning Inventory'),
(50,'Sanitizers',706,'Cleaning Inventory'),
(51,'First Aid',801,'Common Inventory'),
(52,'Luggage',802,'Common Inventory'),
(53,'Vending Machine',803,'Common Inventory'),
(54,'Fire Extinguishers',804,'Common Inventory'),
(55,'Hair Dryer',805,'Toilet Inventory'),
(56,'SOAP',806,'Toilet Inventory'),
(57,'Shampoos',807,'Toilet Inventory'),
(58,'Tissues',808,'Toilet Inventory'),
(59,'Towels',809,'Toilet Inventory'),
(60,'Bathtubs',810,'Toilet Inventory'),
(61,'Camord',811,'Toilet Inventory'),
(62,'Shower',812,'Toilet Inventory'),
(63,'Face Wash',813,'Toilet Inventory');
-- 26. PRODUCT_IN_GODOWN (All 63 mappings)
INSERT INTO PRODUCT_IN_GODOWN (product_id, godown_id) VALUES
(1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1),(10,1),(11,1),
(12,2),(13,2),(14,2),(15,2),(16,2),(17,2),(18,2),(19,2),(20,2),(21,2),(22,2),(23,2),(24,
2),(25,2),
(26,3),(27,3),(28,3),(29,3),(30,3),(31,3),(32,3),(33,3),
(34,4),(35,4),(36,4),
(37,5),(38,5),(39,5),(40,5),(41,5),(42,5),(43,5),
(44,6),(45,6),(46,6),(47,6),(48,6),(49,6),(50,6),
(51,7),(52,7),(53,7),(54,7),
(55,8),(56,8),(57,8),(58,8),(59,8),(60,8),(61,8),(62,8),(63,8);
-- 27. PRODUCT_IN_INVENTORY (All 63 mappings)
INSERT INTO PRODUCT_IN_INVENTORY (product_id, inventory_id) VALUES
(1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1),(11,1),
(12,2),(13,2),(14,2),(15,2),(16,2),(17,2),(18,2),(19,2),(20,2),(21,2),(22,2),(23,2),(24,
2),(25,2),
(26,3),(27,3),(28,3),(29,3),(30,3),(31,3),(32,3),(33,3),
(34,4),(35,4),(36,4),
(37,5),(38,5),(39,5),(40,5),(41,5),(43,5),
(44,6),(45,6),(46,6),(47,6),(48,6),(49,6),(50,6),
(51,7),(52,7),(53,7),(54,7),
(55,8),(56,8),(57,8),(58,8),(59,8),(60,8),(61,8),(62,8),(63,8);
-- 28. SUPPLIER (8 suppliers)
INSERT INTO SUPPLIER (supplier_id, supplier_name, reg_no, cnic, city, country, 
house_no, street_no, area) VALUES
(1,'Bilal Jajja',112,'33305-663748-9','Migery','UK','TT1','Street 11','Middle Corx'),
(2,'Bilal Ahmad',212,'32303-624526-9','Jajoba','Bermingham','MI1','Go 1','Alabi'),
(3,'Hassan Aftab',315,'33315-663378-9','Islamabad','UK','MT-1','Street 1T','Isaac'),
(4,'Kabeer Ahmad',411,'30315-662325-9','Gujranwala','Pakistan','5','khujian','Ali 
pur'),
(5,'Simal Ahmad',512,'31335-622325-9','Mijogni','Sweden','GFY','KJ LDI','Hawasa'),
(6,'Talal Ahmad',398,'31362-693425-9','New York','America','Apartment 
14','Alexander st.','Perk Coffee house'),
(7,'Imaad Ahmad',678,'33345-746436-9','Lahore','Pakistan','142','Baig Sanitory 
Store','Wapdatown'),
(8,'Kamran Hassan',298,'39462-483658-9','jodurh','Sweden','763','Kotre','Avenue 
Tetris');
-- 29. SUPPLIER_PRODUCT (All 63 relationships)
INSERT INTO SUPPLIER_PRODUCT (supplier_id, product_id, date_supplied) 
VALUES
(1,1,'2018-01-01'),(1,2,'2018-01-01'),(1,3,'2018-01-01'),(1,4,'2018-01-01'),
(1,5,'2018-01-01'),(1,6,'2018-01-01'),(1,7,'2018-01-01'),(1,8,'2018-01-01'),
(1,9,'2018-01-01'),(1,10,'2018-01-01'),(1,11,'2018-01-01'),
(2,12,'2018-01-10'),(2,13,'2018-01-10'),(2,14,'2018-01-10'),(2,15,'2018-01-10'),
(2,16,'2018-01-10'),(2,17,'2018-01-10'),(2,18,'2018-01-10'),(2,19,'2018-01-10'),
(2,20,'2018-01-10'),(2,21,'2018-01-10'),(2,22,'2018-01-10'),(2,23,'2018-01-10'),
(2,24,'2018-01-10'),(2,25,'2018-01-10'),
(3,26,'2018-01-15'),(3,27,'2018-01-15'),(3,28,'2018-01-15'),(3,29,'2018-01-15'),
(3,30,'2018-01-15'),(3,31,'2018-01-15'),(3,32,'2018-01-15'),(3,33,'2018-01-15'),
(4,34,'2018-01-20'),(4,35,'2018-01-20'),(4,36,'2018-01-20'),
(5,37,'2018-01-25'),(5,38,'2018-01-25'),(5,39,'2018-01-25'),(5,40,'2018-01-25'),
(5,41,'2018-01-25'),(5,42,'2018-01-25'),(5,43,'2018-01-25'),
(6,44,'2018-01-30'),(6,45,'2018-01-30'),(6,46,'2018-01-30'),(6,47,'2018-01-30'),
(6,48,'2018-01-30'),(6,49,'2018-01-30'),(6,50,'2018-01-30'),
(7,51,'2018-02-05'),(7,52,'2018-02-05'),(7,53,'2018-02-05'),(7,54,'2018-02-05'),
(8,55,'2018-02-10'),(8,56,'2018-02-10'),(8,57,'2018-02-10'),(8,58,'2018-02-10'),
(8,59,'2018-02-10'),(8,60,'2018-02-10'),(8,61,'2018-02-10'),(8,62,'2018-02-10'),
(8,63,'2018-02-10');
-- 30. SHIPMENT (8 shipments)
ALTER TABLE shipment 
MODIFY COLUMN area VARCHAR(25);
INSERT INTO SHIPMENT (shipment_no, shipment_date, serial_no, city, country, 
house_no, street_no, area, supplier_id) VALUES
(1,'2017-10-01',532100,'AmsterDam','UK','142','Lane 15','Middle Corx',1),
(2,'2017-10-10',736492,'dotrox','Bermingham','1E5','St East','Church William 
Colony',2),
(3,'2017-10-20',749365,'Modem','UK','GT51','GT-12','Anna Steel',3),
(4,'2017-10-30',829493,'Sialkot','Pakistan','142','chittar Mor','Chaiyan Wali',4),
(5,'2017-11-10',237347,'Pong','Sweden','YtG','Fort View','Rising Guild',5),
(6,'2017-11-20',497239,'New York','America','Apartment 14','Alexander st.','Perk 
Coffee house',6),
(7,'2017-11-30',394725,'Islamabad','Pakistan','Ty1','Road 3Et','Green Belt',7),
(8,'2017-12-10',346529,'Morgen','Sweden','YY51','Dschuets Ysue','Middle 
Corx',8);
-- 31. PRODUCT_SHIPMENT (All 63 mappings)
INSERT INTO PRODUCT_SHIPMENT (product_id, shipment_id) VALUES
(1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1),(10,1),(11,1),
(12,2),(13,2),(14,2),(15,2),(16,2),(17,2),(18,2),(19,2),(20,2),(21,2),(22,2),(23,2),(24,
2),(25,2),
(26,3),(27,3),(28,3),(29,3),(30,3),(31,3),(32,3),(33,3),
(34,4),(35,4),(36,4),
(37,5),(38,5),(39,5),(40,5),(41,5),(42,5),(43,5),
(44,6),(45,6),(46,6),(47,6),(48,6),(49,6),(50,6),
(51,7),(52,7),(53,7),(54,7),
(55,8),(56,8),(57,8),(58,8),(59,8),(60,8),(61,8),(62,8),(63,8);
-- 32. FOOD_ORDER (19 orders)
INSERT INTO FOOD_ORDER (food_order_id, food_item_id, guest_id, 
quantity_ordered) VALUES
(1,1,1,5),
(2,10,2,1),
(3,4,2,1),
(4,6,3,2),
(5,12,3,1),
(6,8,4,1),
(7,12,4,1),
(8,8,5,1),
(9,12,5,1),
(10,11,6,1),
(11,12,6,1),
(12,5,7,1),
(13,15,7,1),
(14,5,8,1),
(15,15,8,1),
(16,11,9,1),
(17,12,9,1),
(18,11,10,1),
(19,14,10,1);
-- 33. EMPLOYEE_SERVE_GUEST (10 services)
INSERT INTO EMPLOYEE_SERVE_GUEST (service_id, guest_id, employee_id) 
VALUES
(6,1,15),
(9,2,15),
(7,3,16),
(5,4,14),
(2,5,15),
(1,6,16),
(3,7,14),
(5,8,15),
(4,9,16),
(8,10,15);
-- 1. Total Employees
SELECT COUNT(employee_id) AS total_employees FROM employee;
-- 2. Total Guests
SELECT COUNT(guestid) AS total_guests FROM guest;
-- 3. Total Rooms
SELECT COUNT(room_id) AS total_rooms FROM room;
-- 4. Employees by Type
SELECT e.employee_type_id, et.designation, COUNT(e.employee_id) AS 
employee_count
FROM employee e
JOIN employee_type et ON e.employee_type_id = et.employee_type_id
GROUP BY e.employee_type_id, et.designation;
-- 5. Guests Using Services
SELECT DISTINCT guest_id FROM employee_serve_guest;
-- 6. Reservations per Guest
SELECT guest_id, COUNT(reservation_id) AS total_reservations
FROM reservation
GROUP BY guest_id;
-- 7. Rooms by Type
SELECT r.roomtype_id, rt.roomtype_name, COUNT(r.roomtype_id) AS 
room_count
FROM room r
JOIN roomtype rt ON r.roomtype_id = rt.roomtype_id
GROUP BY r.roomtype_id, rt.roomtype_name;
-- 8. Vehicles by Type
SELECT p.vehicle_type_id, vt.vehicle_type_name, COUNT(p.vehicle_type_id) AS 
vehicle_count
FROM parking_area p
JOIN vehicle_type vt ON p.vehicle_type_id = vt.vehicle_type_id
GROUP BY p.vehicle_type_id, vt.vehicle_type_name;
-- 9. Payment Type Usage
SELECT rb.payment_type_id, pt.payment_type_name, COUNT(rb.guest_id) AS 
usage_count
FROM reservation_bill rb
JOIN payment_type pt ON rb.payment_type_id = pt.payment_type_id
GROUP BY rb.payment_type_id, pt.payment_type_name;
-- 10. Food Items in Menus
SELECT food_menu_id, COUNT(food_item_id) AS items_per_menu
FROM food_menu_item
GROUP BY food_menu_id;
-- 11. Products in Inventories
SELECT product_id, COUNT(inventory_id) AS inventory_count
FROM product_in_inventory
GROUP BY product_id;
-- 12. Total Hotel Expenses
SELECT SUM(expense_cost) AS total_expenses FROM hotel_expense;
-- 13. Total Payments Collected
SELECT SUM(payment_amount) AS total_payments FROM reservation_bill;
-- 14. Suppliers per Product
SELECT product_id, COUNT(supplier_id) AS supplier_count
FROM supplier_product
GROUP BY product_id;
-- 15. Products per Supplier
SELECT supplier_id, COUNT(product_id) AS product_count
FROM supplier_product
GROUP BY supplier_id;
-- 16. Menu Item Frequency
SELECT food_item_id, COUNT(food_menu_id) AS menu_appearances
FROM food_menu_item
GROUP BY food_item_id;
-- 17. Employee Salary Analysis
SELECT 
 et.designation,
 MIN(e.salary) AS min_salary,
 AVG(e.salary) AS avg_salary,
 MAX(e.salary) AS max_salary
FROM employee e
JOIN employee_type et ON e.employee_type_id = et.employee_type_id
GROUP BY et.designation;
-- 18. Guest Demographics
SELECT 
 country,
 gender,
 COUNT(guestid) AS guest_count
FROM guest
GROUP BY country, gender;
-- 19. Room Occupancy Rates
SELECT 
 rs.roomstatus,
 COUNT(r.room_id) AS room_count,
 ROUND((COUNT(r.room_id)/(SELECT COUNT(*) FROM room))*100, 2) AS 
occupancy_rate
FROM room r
JOIN roomstatus rs ON r.roomstatus_id = rs.roomstatus_id
GROUP BY rs.roomstatus;
-- 20. Service Popularity
SELECT 
 s.service_name,
 COUNT(esg.service_id) AS usage_count
FROM employee_serve_guest esg
JOIN service s ON esg.service_id = s.service_id
GROUP BY s.service_name
ORDER BY usage_count DESC;
-- 21. Product Stock Levels
SELECT 
 p.product_name,
 i.quantity AS current_stock
FROM product p
JOIN inventory i ON p.product_id = i.inventory_id;
-- 22. Bank Account Balances
SELECT 
 b.name AS bank_name,
 SUM(ba.balance) AS total_balance
FROM bank_account ba
JOIN bank b ON ba.bank_id = b.bank_id
GROUP BY b.name;
-- 23. Employee Contact Details
SELECT 
 e.first_name,
 e.last_name,
 eci.phone_number
FROM employee e
JOIN employee_contact_info eci ON e.employee_id = eci.employee_id;
-- 24. Food Order Details
SELECT 
 g.first_name,
 g.last_name,
 fi.food_item_name,
 fo.quantity_ordered,
 (fi.per_item_price * fo.quantity_ordered) AS total_cost
FROM food_order fo
JOIN guest g ON fo.guest_id = g.guestid
JOIN food_item fi ON fo.food_item_id = fi.food_item_id;
-- 25. Shipment Tracking
SELECT 
 s.shipment_date,
 sp.supplier_name,
 COUNT(ps.product_id) AS products_shipped
FROM shipment s
JOIN supplier sp ON s.supplier_id = sp.supplier_id
JOIN product_shipment ps ON s.shipment_no = ps.shipment_id
GROUP BY s.shipment_date, sp.supplier_name;
select * from godown;