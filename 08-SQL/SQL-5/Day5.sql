------------DAY'5-------------
--CREATE:INSERT
--  READ:SELECT
-- UPDATE:?
--DELETE:DELETE,TRUNCATE

--26-UPDATE komutu:tablodaki veriyi günceller
--syntax: UPDATE table_name
--        SET column_name=yeni değer, column_name2=yeni değer 2
--        WHERE condition


--idsi 123456789 olan çalışanın isyeri ismini 'Trendyol' olarak güncelleyeniz.
UPDATE calisanlar3
SET isyeri='Trendyol'
WHERE id=123456789;

-- id’si 567890123 olan çalışanın ismini 'Veli Yıldırım' ve 
--sehirini 'Bursa' olarak güncelleyiniz.

UPDATE calisanlar3
SET isim='Veli Yıldırım', sehir='Bursa'
WHERE id=567890123;

--  markalar tablosundaki marka_id değeri 102 ye eşit veya büyük olanların marka_id’sini 2 ile çarparak değiştirin.

UPDATE markalar
SET marka_id=marka_id*2
WHERE marka_id>=102;


-- markalar tablosundaki tüm markaların calisan_sayisi değerlerini marka_id ile toplayarak güncelleyiniz.

UPDATE markalar
SET calisan_sayisi=calisan_sayisi+marka_id;

--calisanlar3 tablosundan Ali Seker’in isyerini, 'Veli Yıldırım' ın isyeri ismi ile güncelleyiniz.

UPDATE calisanlar3
SET isyeri=(SELECT isyeri FROM calisanlar3 WHERE isim='Veli Yıldırım')
WHERE isim='Ali Seker';

--calisanlar3 tablosunda maasi 1500 olanların isyerini, markalar tablosunda
--calisan_sayisi 20000 den fazla olan markanın ismi ile değiştiriniz.

UPDATE calisanlar3
SET isyeri=(SELECT marka_isim FROM markalar WHERE calisan_sayisi>20000 )
WHERE maas=1500;

--calisanlar3 tablosundaki isyeri 'Vakko' olanların sehir bilgisinin sonuna ' Şubesi' ekleyiniz.
UPDATE calisanlar3
SET sehir=sehir || ' Şubesi'
WHERE isyeri='Vakko';
--alternatif
UPDATE calisanlar3
SET sehir=CONCAT(sehir,' Şubesi')
WHERE isyeri='Vakko';

SELECT * FROM calisanlar3;
SELECT * FROM markalar;

--27-IS NULL condition

CREATE TABLE people
(
ssn char(9),
name varchar(50),
address varchar(50)
);
INSERT INTO people VALUES(123456789, 'Ali Can', 'Istanbul');
INSERT INTO people VALUES(234567890, 'Veli Cem', 'Ankara');
INSERT INTO people VALUES(345678901, 'Mine Bulut', 'Izmir');
INSERT INTO people (ssn, address) VALUES(456789012, 'Bursa');
INSERT INTO people (ssn, address) VALUES(567890123, 'Denizli');
INSERT INTO people (ssn, name) VALUES(567890123, 'Veli Han');

SELECT * FROM people;

--people tablosundaki name sütununda NULL olan değerleri listleyiniz.
SELECT *
FROM people
WHERE name IS NULL;

--people tablosundaki adres sütununda NULL olmayan değerleri listleyiniz.
SELECT *
FROM people
WHERE address IS NOT NULL;

--people tablosunda name sütunu null olanların name değerini 
--'MISSING...' olarak güncelleyiniz..

UPDATE people
SET name='MISSING...'
WHERE name IS NULL;

--people tablosunda adres sütunu null olanların adres değerini 
--'MISSING...' olarak güncelleyiniz..

UPDATE people
SET address='MISSING...'
WHERE address IS NULL;

--28-ORDER BY:kayıtları belirli bir field(sütuna)a göre varsayılan olarak NATURAL(artan,ASCENDING) olarak sıralar.


CREATE TABLE person
(
ssn char(9),
isim varchar(50),
soyisim varchar(50),  
adres varchar(50)
);

INSERT INTO person VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO person VALUES(234567890, 'Veli','Cem', 'Ankara');  
INSERT INTO person VALUES(345678901, 'Mine','Bulut', 'Ankara');  
INSERT INTO person VALUES(256789012, 'Mahmut','Bulut', 'Istanbul'); 
INSERT INTO person VALUES (344678901, 'Mine','Yasa', 'Ankara');  
INSERT INTO person VALUES (345678901, 'Veli','Yilmaz', 'Istanbul');
INSERT INTO person VALUES(256789018, 'Samet','Bulut', 'Izmir'); 
INSERT INTO person VALUES(256789013, 'Veli','Cem', 'Bursa'); 
INSERT INTO person VALUES(256789010, 'Samet','Bulut', 'Ankara'); 

SELECT * FROM person;

--person tablosundaki tüm kayıtları adrese göre (artan) sıralayarak listeleyiniz.

SELECT *
FROM person
ORDER BY adres ASC;--defaultta da ASC:artan


--person tablosundaki tüm kayıtları soyisime göre (azalan) sıralayarak listeleyiniz.

SELECT * 
FROM person
ORDER BY soyisim DESC;--DESC(ENDING):azalan sıralı


--person tablosundaki soyismi Bulut olanları isime göre (azalan) sıralayarak listeleyiniz.

SELECT *
FROM person
WHERE soyisim='Bulut'
ORDER BY isim DESC;


SELECT *
FROM person
WHERE soyisim='Bulut'
ORDER BY 2 DESC;--not recommended--tavsiye edilmez

--person tablosundaki tum kayitlari SSN numarasi buyukten kucuge olarak siralayiniz
SELECT *
FROM person
ORDER BY ssn DESC;

--person tablosundaki tum kayitlari isimler Natural sirali, Soyisimler ters sirali olarak listeleyiniz

SELECT *
FROM person
ORDER BY isim ASC, soyisim DESC

--İsim ve soyisim değerlerini, soyisim kelime uzunluklarına göre sıralayarak listeleyiniz.
SELECT isim,soyisim,LENGTH(soyisim) AS karakter_sayisi
FROM person
ORDER BY LENGTH(soyisim)


--Tüm isim ve soyisim değerlerini aralarında bir boşluk ile aynı sutunda çağırarak her bir isim ve 
--soyisim değerinin toplam uzunluğuna göre sıralayınız.

SELECT isim ||' '||soyisim tam_isim, LENGTH(isim || soyisim) karakter_sayisi
FROM person p
ORDER BY LENGTH(isim || soyisim)
--alternatif
SELECT CONCAT(isim,' ',soyisim) AS tam_isim
FROM person
ORDER BY LENGTH(isim)+LENGTH(soyisim)

--NOT: AS ile alias oluşturmak yerine bir boşluk bırakarak
--tablo veya sütunlara geçici isim verebiliriz.

SELECT * FROM calisanlar3;
--calisanlar3 tablosunda maaşı ortalama maaştan yüksek olan çalışanların
--isim,şehir ve maaşlarını maaşa göre artan sıralayarak listeleyiniz.

SELECT isim,sehir,maas
FROM calisanlar3
WHERE maas>(SELECT AVG(maas) FROM calisanlar3)
ORDER BY maas;


--29-UNION:iki farklı sorgunun sonucunu birleştirerek görüntülememizi sağlar.
          --tekrarlı değerleri göstermez.
--UNION ALL operator:UNION ile aynı işlevi görür ancak tekrarlı verileri de gösterir

DROP TABLE developers;

CREATE TABLE developers(
id SERIAL PRIMARY KEY,
name varchar(50),
email varchar(50) UNIQUE,
salary real,
prog_lang varchar(20),
city varchar(50),
age int	
);

INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Abdullah Bey','abdullah@mail.com',4000,'Java','Ankara',28);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Mehmet Bey','mehmet@mail.com',5000,'JavaScript','Istanbul',35);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Ayşenur Hanım ','aysenur@mail.com',5000,'Java','Izmir',38);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Kübra Hanım','kubra@mail.com',4000,'JavaScript','Istanbul',32);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Muhammed Bey','muhammed@mail.com',6000,'Java','Izmir',25);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Fevzi Bey','fevzi@mail.com',6000,'Html','Istanbul',28);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Enes Bey','enes@mail.com',5500,'Css','Ankara',28);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Tansu Hanım','tansu@mail.com',5000,'Java','Bursa',32);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Said Bey','said@mail.com',4500,'Html','Izmir',33);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Mustafa Bey','mustafa@mail.com',4500,'Css','Bursa',32);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Hakan Bey','hakan@mail.com',7000,'C++','Konya',38);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Deniz Bey','deniz@mail.com',4000,'C#','Istanbul',30);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Ummu Hanım','ummu@mail.com',4000,'C#','Bursa',29);


CREATE TABLE contact_info(
address_id int,
street varchar(30),
number int,	
city varchar(30),
FOREIGN KEY(address_id) REFERENCES developers(id)	
);

INSERT INTO contact_info VALUES(1,'Kaya Sok.',5,'Bursa');
INSERT INTO contact_info VALUES(2,'Kaya Sok.',3,'Ankara');
INSERT INTO contact_info VALUES(3,'Can Sok.',10,'Bursa');
INSERT INTO contact_info VALUES(4,'Gül Sok.',12,'Ankara');
INSERT INTO contact_info VALUES(5,'Can Sok.',4,'Afyon');
INSERT INTO contact_info VALUES(6,'Taş Sok.',6,'Bolu');
INSERT INTO contact_info VALUES(7,'Dev Sok.',6,'Sivas');
INSERT INTO contact_info VALUES(8,'Dev Sok.',8,'Van');


SELECT * FROM developers;
SELECT * FROM contact_info;

--Yaşı 25’den büyük olan developer isimlerini ve 
--yaşı 30'dan küçük developerların kullandığı prog. dillerini
--tekrarsız gösteren sorguyu yaziniz

SELECT name FROM developers WHERE age>25--12
UNION
SELECT prog_lang FROM developers WHERE age<30--5

--NOT:UNION/UNION ALL birleştirdiğimiz sorgular aynı sayıda sütunu göstermeli ve alt alta gelecek olan sütunun 
--data tipi aynı olmalı

--Yaşı 25’den büyük olan developer isimlerini ve 
--yaşı 30'dan küçük developerların kullandığı prog. dillerini
--tekrarlı gösteren sorguyu yaziniz
SELECT name FROM developers WHERE age>25
UNION ALL
SELECT prog_lang FROM developers WHERE age<30

--Java kullananların maaşını ve prog. dilini ve 
--JavaScript kullananların yaşını ve prog. dilini
--tekrarsız gösteren sorguyu yaziniz

SELECT salary maas_yas, prog_lang FROM developers WHERE prog_lang='Java'
UNION
SELECT age maas_yas, prog_lang FROM developers WHERE prog_lang='JavaScript'

--id si 8 olan developerın çalıştığı şehir ve maaşını
--iletişim adresindeki şehir ve kapı nosunu görüntüleyiniz.
SELECT city, salary maas_kapino FROM developers WHERE id=8
UNION
SELECT city, number maas_kapino FROM contact_info WHERE address_id=8

--developers tablosundaki şehirler ve
--calisanlar3 tablosunda sehirlerin
--tümünü tekrarsız olarak listeleyiniz

SELECT city FROM developers
UNION
SELECT sehir FROM calisanlar3

/*-------- ÖDEV --------
Veritabanında bulunan bir tabloya yeni veriler eklemek ve mevcut verileri güncellemek için "UPDATE" komutu kullanılır. Bu ödevde, mevcut bir tabloyu güncelleme işlemleri yapmanızı istiyorum.

1. Soru: Bir "Employees" tablosu düşünelim. Bu tabloda şirkette çalışanlara ait bilgiler bulunmaktadır. Tabloda aşağıdaki alanlar yer almaktadır:
employee_id (çalışan numarası)
employee_name (çalışan adı)
department (çalışanın bağlı olduğu departman)
salary (çalışanın maaşı)
Bu tabloyu kullanarak aşağıdaki güncelleme işlemlerini yapınız:

a) "employee_id" değeri 101 olan çalışanın maaşını 5000 TL olarak güncelleyin.
b) "employee_id" değeri 102 olan çalışanın departmanını "Sales" olarak güncelleyin.
c) "employee_id" değeri 103 olan çalışanın adını "John Doe" olarak güncelleyin.
d) "employee_id" değeri 104 olan çalışanın maaşını 5500 TL ve departmanını "Marketing" olarak güncelleyin.
e) "employee_id" değeri 105 olan çalışanın adını "Jane Smith" ve maaşını 6000 TL olarak güncelleyin.

2. Soru: Bir "Products" tablosu düşünelim. Bu tabloda ürünlere ait bilgiler bulunmaktadır. Tabloda aşağıdaki alanlar yer almaktadır:
product_id (ürün numarası)
product_name (ürün adı)
category (ürün kategorisi)
price (ürün fiyatı)
stock_quantity (stok miktarı)
Bu tabloyu kullanarak aşağıdaki güncelleme işlemlerini yapınız:

a) "product_id" değeri 201 olan ürünün fiyatını 150 TL olarak güncelleyin.
b) "product_id" değeri 202 olan ürünün stok miktarını 100 adet arttırın.
c) "product_id" değeri 203 olan ürünün adını "New Product" olarak güncelleyin.
d) "product_id" değeri 204 olan ürünün fiyatını 200 TL, stok miktarını 50 adet azaltın ve kategorisini "Electronics" olarak güncelleyin.
e) "product_id" değeri 205 olan ürünün fiyatını 300 TL ve stok miktarını 20 adet olarak güncelleyin.
*/