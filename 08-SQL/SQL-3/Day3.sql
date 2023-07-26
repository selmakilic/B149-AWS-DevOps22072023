-------- SQL 3 --------
-- TEKRAR

CREATE TABLE calisanlar(
	id char(5) PRIMARY KEY,--başka bir tablo tarafından referans alınacak
	isim varchar(50) UNIQUE,
	maas int NOT NULL,
	ise_baslama date
);--PARENT

CREATE TABLE adresler(
	adres_id char(5),
	sokak varchar(30),
	cadde varchar(30),
	sehir varchar(20),
FOREIGN KEY(adres_id) REFERENCES calisanlar(id)	
);--CHILD

INSERT INTO calisanlar VALUES('10002', 'Donatello' ,12000, '2018-04-14'); 
INSERT INTO calisanlar VALUES('10003', null, 5000, '2018-04-14');--isim için NOT NULL yok, kabul eder
INSERT INTO calisanlar VALUES('10004', 'Donatello', 5000, '2018-04-14');--isim için UNIQUE var, KABUL ETMEZ
INSERT INTO calisanlar VALUES('10005', 'Michelangelo', 5000, '2018-04-14');--+
INSERT INTO calisanlar VALUES('10006', 'Leonardo', null, '2019-04-12');--mass NOT NULL, KABUL ETMEZ
INSERT INTO calisanlar VALUES('10007', 'Raphael', '', '2018-04-14');--maas int olmalıydı, KABUL ETMEZ
INSERT INTO calisanlar VALUES('', 'April', 2000, '2018-04-14');--empty NULL değildir
INSERT INTO calisanlar VALUES('', 'Ms.April', 2000, '2018-04-14');--PK:UNIQUE, 2.empty, KABUL ETMEZ
INSERT INTO calisanlar VALUES('10002', 'Splinter' ,12000, '2018-04-14');--PK:UNIQUE, KABUL ETMEZ
INSERT INTO calisanlar VALUES( null, 'Fred' ,12000, '2018-04-14');--PK:NOT NULL, KABUL ETMEZ
INSERT INTO calisanlar VALUES('10008', 'Barnie' ,10000, '2018-04-14');
INSERT INTO calisanlar VALUES('10009', 'Wilma' ,11000, '2018-04-14');
INSERT INTO calisanlar VALUES('10010', 'Betty' ,12000, '2018-04-14');

INSERT INTO adresler VALUES('10003','Ninja Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Kaya Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Taş Sok', '30.Cad.','Konya');

--parent tableda olmayan datayı child tableda FK sütununa ekleyemeyiz.
INSERT INTO adresler VALUES('10012','Taş Sok', '30.Cad.','Konya'); -- KABUL ETMEZ

--FK null kabul eder
INSERT INTO adresler VALUES(NULL,'Taş Sok', '23.Cad.','Konya');
INSERT INTO adresler VALUES(NULL,'Taş Sok', '33.Cad.','Bursa');

SELECT * FROM calisanlar;
SELECT * FROM adresler;
SELECT isim FROM calisanlar;

--14-WHERE CONDITION(koşulu)
--calisanlar tablosundan ismi 'Donatello' olanları listeleyiniz.
SELECT * FROM calisanlar WHERE isim='Donatello';

--calisanlar tablosundan maası 5000den fazla olanları listeleyiniz.
SELECT * FROM calisanlar WHERE maas>5000;

--calisanlar tablosundan maası 5000den fazla olanların sadece isim ve maaşlarını listeleyiniz.
SELECT isim,maas FROM calisanlar WHERE maas>5000;

--adresler tablosundan sehiri 'Konya' ve 
--adres_id si 10002 olan tüm verileri getir
SELECT * FROM adresler WHERE sehir='Konya' AND adres_id='10002';

--sehiri 'Konya' veya 'Bursa' olan adreslerin cadde ve sehir bilgilerini getir.
SELECT cadde,sehir FROM adresler WHERE sehir='Konya' OR sehir='Bursa';

--15-DELETE FROM .. WHERE.. komutu:koşula uyan kayıtları tablodan siler
CREATE TABLE ogrenciler1
(
	id int,
	isim VARCHAR(50),
	veli_isim VARCHAR(50),
	yazili_notu int       
);

INSERT INTO ogrenciler1 VALUES(122, 'Kerem Can', 'Fatma',75);
INSERT INTO ogrenciler1 VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler1 VALUES(124, 'Veli Han', 'Ayse',85);
INSERT INTO ogrenciler1 VALUES(125, 'Kemal Tan', 'Hasan',85);
INSERT INTO ogrenciler1 VALUES(126, 'Ahmet Ran', 'Ayse',95);
INSERT INTO ogrenciler1 VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler1 VALUES(128, 'Mustafa Bak', 'Ali', 99);
INSERT INTO ogrenciler1 VALUES(129, 'Mehmet Bak', 'Alihan', 89);

SELECT * FROM ogrenciler1;

--id=123 olan kaydı siliniz.
DELETE FROM ogrenciler1 WHERE id=123;
--ismi Kemal Tan olan kaydı siliniz.
DELETE FROM ogrenciler1 WHERE isim='Kemal Tan';
--ismi Ahmet Ran veya Veli Han olan kayıtları siliniz.
DELETE FROM ogrenciler1 WHERE isim='Ahmet Ran' OR isim='Veli Han';

--ÖDEV--
-- ismi Mustafa Bak ve id'si 128 olan kaydı siliniz.
-- id'si 122, 125 veya 126 olanları silelim.
-- id 'si 126'dan büyük olan kayıtları silelim.

--16-a-Tablodaki tüm verileri silme:DELETE FROM <table_name> komutunu koşulsuz kullanırsak 
--tablodaki tüm kayıtları siler, talo kalır
--sairler tablosundaki tüm kayıtları listeleyelim.
SELECT * FROM sairler;

----sairler tablosundaki tüm kayıtları siliniz.
DELETE FROM sairler;--tablodaki tüm kayıtlar silinir ancak tablo silinmez

--16-b-Tablodaki tüm verileri silme:TRUNCATE TABLE
SELECT * FROM doctors;

--doctors tablosundaki tüm kayıtları siliniz.
TRUNCATE TABLE doctors;--bu komut ile bir koşul belirtemeyiz, WHERE kullanılamaz.

--17-parent - child ilişkisi olan tablolardan kayıt silme
SELECT * FROM calisanlar;--PARENT
SELECT * FROM adresler;--CHILD

--calisanlar tablosundaki tüm kayıtları siliniz.
DELETE FROM calisanlar;--adresler tablosundan ref. alındığı için silmez
DELETE FROM calisanlar WHERE id='10002';--adresler tablosundan ref. alındığı için silmez

DELETE FROM adresler WHERE adres_id='10002';--bu kayıt için ilişki kesildi
DELETE FROM calisanlar WHERE id='10002';--artık ref. alınmadığı için siler

DELETE FROM adresler;--ilişki tamamen kesildi.
DELETE FROM calisanlar;--referans alan kayıt olmadığından siler

--18-on delete cascade:kademeli silme işlemini aktif hale getirir
CREATE TABLE talebeler
(
	id int primary key,  
	isim VARCHAR(50),
	veli_isim VARCHAR(50),
	yazili_notu int
);--parent

CREATE TABLE notlar( 
	talebe_id int,
	ders_adi varchar(30),
	yazili_notu int,
	CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES talebeler(id)
	ON DELETE CASCADE	
);--child

INSERT INTO talebeler VALUES(122, 'Kerem Can', 'Fatma',75);
INSERT INTO talebeler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO talebeler VALUES(124, 'Veli Han', 'Ayse',85);
INSERT INTO talebeler VALUES(125, 'Kemal Tan', 'Hasan',85);
INSERT INTO talebeler VALUES(126, 'Ahmet Ran', 'Ayse',95);
INSERT INTO talebeler VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO talebeler VALUES(128, 'Mustafa Bak', 'Ali', 99);
INSERT INTO talebeler VALUES(129, 'Mehmet Bak', 'Alihan', 89);

INSERT INTO notlar VALUES (123,'kimya',75);
INSERT INTO notlar VALUES (124, 'fizik',65);
INSERT INTO notlar VALUES (125, 'tarih',90);
INSERT INTO notlar VALUES (126, 'Matematik',90);
INSERT INTO notlar VALUES (127, 'Matematik',90);
INSERT INTO notlar VALUES (null, 'tarih',90);

--notlar tablosundan id=123 olan kaydı siliniz.
DELETE FROM notlar WHERE talebe_id=123;

--talebeler tablosundan id=126 olan kaydı siliniz.
DELETE FROM talebeler WHERE id=126;--parent
--parenttan kayıt silmek istediğimizde CASCADE özelliğinden önce varsa 
--childdan ilişkili olan kaydı siler sonra parenttan siler

DELETE FROM talebeler;--parenttaki kayıtlar ile birlikte childda referans alan kayıtları da siler

SELECT * FROM notlar;
SELECT * FROM talebeler;

--19-Tabloyu silme:tabloyu SCHEMADAN kaldırma
--sairler tablosunu siliniz.
DROP TABLE sairler;--DDL

--talebeler tablosunu siliniz.
DROP TABLE talebeler;--ilişki tanımlı old. için silmez
DROP TABLE talebeler CASCADE;--ilişki iptal edilip silme gerçekleşir

--talebeler1 tablosunu siliniz.
DROP TABLE talebeler1;
DROP TABLE IF EXISTS talebeler1;--hata almamak için

--20-IN CONDITION
CREATE TABLE musteriler  (
	urun_id int,  
	musteri_isim varchar(50),
	urun_isim varchar(50)
);

INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');
INSERT INTO musteriler VALUES (20, 'John', 'Apple');
INSERT INTO musteriler VALUES (30, 'Amy', 'Palm');
INSERT INTO musteriler VALUES (20, 'Mark', 'Apple');
INSERT INTO musteriler VALUES (10, 'Adem', 'Orange');
INSERT INTO musteriler VALUES (40, 'John', 'Apricot');
INSERT INTO musteriler VALUES (20, 'Eddie', 'Apple');

SELECT * FROM musteriler;

--Müşteriler tablosundan ürün ismi 'Orange', 'Apple' veya 'Apricot' olan verileri listeleyiniz.
SELECT *
FROM musteriler
WHERE urun_isim='Orange' OR urun_isim='Apple' OR urun_isim='Apricot';

--2. yol
SELECT *
FROM musteriler
WHERE urun_isim IN ('Orange','Apple','Apricot');

--Müşteriler tablosundan müşteri ismi 'John', 'Mark' veya 'Eddie' olan verileri listeleyiniz.
SELECT *
FROM musteriler
WHERE musteri_isim IN ('John','Mark','Eddie');

--Müşteriler tablosundan ürün ismi 'Orange', 'Apple' ve 'Apricot' olmayan verileri listeleyiniz.
SELECT *
FROM musteriler
WHERE urun_isim NOT IN ('Orange','Apple','Apricot');

--Müşteriler tablosundan müşteri ismi 'John', 'Mark' veya 'Eddie' olmayan verileri listeleyiniz.
SELECT *
FROM musteriler
WHERE musteri_isim NOT IN ('John','Mark','Eddie');

--21-BETWEEN .. AND .. Komutu
--Müşteriler tablosunda urun_id 20 ile 40(dahil) arasinda olan urunlerin tum bilgilerini listeleyiniz
SELECT *
FROM musteriler
WHERE urun_id>=20 AND urun_id<=40;

--2.yol
SELECT *
FROM musteriler
WHERE urun_id BETWEEN 20 AND 40;--20 ve 40 dahil

--Müşteriler tablosunda urun_id 20 den küçük veya 30(dahil değil) dan büyük olan urunlerin tum bilgilerini listeleyiniz
SELECT *
FROM musteriler
WHERE urun_id<20 OR urun_id>30;

--2.yol
SELECT *
FROM musteriler
WHERE urun_id NOT BETWEEN 20 AND 30;--20 ve 30 dahil olmak üzere 20-30 aralığında değil

--22-AGGREGATE Fonk.
CREATE TABLE calisanlar3 (
	id int, 
	isim VARCHAR(50), 
	sehir VARCHAR(50), 
	maas int, 
	isyeri VARCHAR(20)
);

INSERT INTO calisanlar3 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO calisanlar3 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO calisanlar3 VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO calisanlar3 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO calisanlar3 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO calisanlar3 VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO calisanlar3 VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');

CREATE TABLE markalar
(
	marka_id int, 
	marka_isim VARCHAR(20), 
	calisan_sayisi int
);

INSERT INTO markalar VALUES(100, 'Vakko', 12000);
INSERT INTO markalar VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO markalar VALUES(102, 'Adidas', 10000);
INSERT INTO markalar VALUES(103, 'LCWaikiki', 21000);

SELECT * FROM markalar;
SELECT * FROM calisanlar3;

--calisanlar3 tablosunda max maaşı görüntüleyiniz
SELECT MAX(maas) FROM calisanlar3;

--calisanlar3 tablosunda min maaşı gösteriniz.
SELECT MIN(maas) FROM calisanlar3;

--calisanlar3 tablosunda tüm çalışanların toplam maaşını gösteriniz.
SELECT SUM(maas) FROM calisanlar3;

--calisanlar3 tablosunda tüm çalışanların ortalama maaşını gösteriniz.
SELECT AVG(maas) FROM calisanlar3;
SELECT ROUND(AVG(maas),2) FROM calisanlar3;--ondaliklı kısmı 2 basamağa yuvarlar

--calisanlar3 tablosunda tüm çalışanların sayısını gösteriniz.
SELECT COUNT(*) FROM calisanlar3;

--calisanlar3 tablosunda maaşı 2500 olan çalışanların sayısını gösteriniz.
SELECT COUNT(*) FROM calisanlar3 WHERE maas=2500;

--23-ALIASES:Etiket/Rumuz:tabloya veya sütunlarına geçici isim verebiliriz.
CREATE TABLE workers(
	calisan_id char(9),
	calisan_isim varchar(50),
	calisan_dogdugu_sehir varchar(50)
);

INSERT INTO workers VALUES(123456789, 'Ali Can', 'Istanbul'); 
INSERT INTO workers VALUES(234567890, 'Veli Cem', 'Ankara');  
INSERT INTO workers VALUES(345678901, 'Mine Bulut', 'Izmir');

SELECT * FROM workers;

SELECT calisan_id AS id,calisan_isim AS isim FROM workers;

-- Concatenation İşlemi: İki sütunu birleştirerek tek bir sütun içinde gösterebilirsiniz.
SELECT calisan_id AS id,calisan_isim || calisan_dogdugu_sehir AS isim_sehir FROM workers;

SELECT calisan_id AS id,calisan_isim ||' - '||calisan_dogdugu_sehir AS isim_sehir FROM workers;

/*-------- ÖDEV --------
1. Soru: Bir "Products" tablosu düşünelim. Bu tabloda ürünlere ait bilgiler bulunmaktadır. Tabloda aşağıdaki alanlar yer almaktadır:
product_id (ürün numarası)
product_name (ürün adı)
category (ürün kategorisi)
price (ürün fiyatı)
stock_quantity (stok miktarı)
Bu tablodan "category" alanı "Electronics" olan ve "price" alanı 1000 TL üzerinde olan ürünleri listeleyen SQL sorgusunu yazınız.

2. Soru: Bir "Employees" tablosu düşünelim. Bu tabloda şirkette çalışanlara ait bilgiler bulunmaktadır. Tabloda aşağıdaki alanlar yer almaktadır:
employee_id (çalışan numarası)
employee_name (çalışan adı)
department (çalışanın bağlı olduğu departman)
salary (çalışanın maaşı)
hire_date (çalışanın işe başlama tarihi)
Bu tablodan "department" alanı "Sales" olan ve "salary" alanı 5000 TL'den fazla olan çalışanların isimlerini ve maaşlarını listeleyen SQL sorgusunu yazınız.

3. Soru: Bir "Orders" tablosu düşünelim. Bu tabloda müşterilere ait sipariş bilgileri bulunmaktadır. Tabloda aşağıdaki alanlar yer almaktadır:
order_id (sipariş numarası)
customer_name (müşteri adı)
order_date (sipariş tarihi)
total_amount (toplam tutar)
status (sipariş durumu)
Bu tablodan "total_amount" alanı 1000 TL üzerinde olan ve "status" alanı "Shipped" olan siparişleri listeleyen SQL sorgusunu yazınız.

4.Soru: Bir "Books" tablosu düşünelim. Bu tabloda kitaplara ait bilgiler bulunmaktadır. Tabloda aşağıdaki alanlar yer almaktadır:
book_id (kitap numarası)
book_name (kitap adı)
author (yazar adı)
genre (kitap türü)
publication_year (yayın yılı)
Bu tablodan "genre" alanı "Romance" olan ve "publication_year" alanı 2000 yılından sonra olan kitapları listeleyen SQL sorgusunu yazınız.
*/