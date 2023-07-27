-------- SQL 4 --------
--24-SUBQUERY--NESTED QUERY
--24-a-SUBQUERY: WHERE ile kullanımı

SELECT * FROM calisanlar3;
SELECT * FROM markalar;

--marka_id si 100 olan markada çalışanları listeleyiniz.

SELECT marka_isim FROM markalar WHERE marka_id=100;--Vakko

SELECT * FROM calisanlar3 WHERE isyeri='Vakko';

--2.yol
SELECT * 
FROM calisanlar3 
WHERE isyeri=  (SELECT marka_isim 
			    FROM markalar 
			    WHERE marka_id=100);

--INTERVIEW QUESTION:calisanlar3 tablosunda max maaşı alan çalışanın tüm fieldlarını listeleyiniz. 
SELECT *
FROM calisanlar3 
WHERE maas=(SELECT MAX(maas) 
			FROM calisanlar3);
			
--Interview Question:calisanlar3 tablosunda ikinci en yüksek maaşı gösteriniz.ÖDEV
--(en yüksek maaştan az ama sütündaki diğer maaşlardan en yükseği)

SELECT MAX(maas)
FROM calisanlar3
WHERE maas<(SELECT MAX(maas)
            FROM calisanlar3)

--calisanlar3 tablosunda ikinci en yüksek maaşı alan çalışanları gösteriniz.
SELECT *
FROM calisanlar3
WHERE maas=(SELECT MAX(maas)
			FROM calisanlar3
			WHERE maas<(SELECT MAX(maas)
            			FROM calisanlar3))



--calisanlar3 tablosunda max veya min maaşı alan çalışanların
-- tüm fieldlarını gösteriniz.

SELECT * 
FROM calisanlar3
WHERE maas=(SELECT MAX(maas) FROM calisanlar3) OR maas=(SELECT MIN(maas) FROM calisanlar3);

SELECT * 
FROM calisanlar3
WHERE maas IN ((SELECT MAX(maas) FROM calisanlar3),(SELECT MIN(maas) FROM calisanlar3));

-- Ankara’da calisani olan markalarin marka id'lerini ve calisan sayilarini listeleyiniz.

SELECT marka_id,calisan_sayisi
FROM markalar
WHERE marka_isim IN ('Vakko','Pierre Cardin','Adidas');


--2.yol
SELECT marka_id,calisan_sayisi
FROM markalar
WHERE marka_isim IN (SELECT isyeri FROM calisanlar3 WHERE sehir='Ankara');

--marka_id’si 101’den büyük olan marka çalişanlarinin isim, maaş ve şehirlerini listeleyiniz.

SELECT isim,maas,sehir
FROM calisanlar3
WHERE isyeri IN (SELECT marka_isim FROM markalar WHERE marka_id>101)

-- Çalisan sayisi 15.000’den cok olan markalarin isimlerini ve 
--bu markada calisanlarin isimlerini ve maaşlarini listeleyiniz.

SELECT isim,maas,isyeri
FROM calisanlar3
WHERE isyeri IN (SELECT marka_isim FROM markalar WHERE calisan_sayisi>15000)


--24-b-SUBQUERY: SELECT komutundan sonra kullanımı

-- Her markanin id’sini, ismini ve toplam kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz.

SELECT marka_id,marka_isim,(SELECT COUNT(DISTINCT sehir) 
							FROM calisanlar3
						    WHERE isyeri=marka_isim) AS sehir_sayisi
FROM markalar;

--DISTINCT komutu:sadece farklı olan değerleri gösterir
SELECT DISTINCT sehir FROM calisanlar3; --1. Kullanım
SELECT DISTINCT(sehir) FROM calisanlar3; --2. Kullanım
SELECT COUNT(DISTINCT(sehir)) FROM calisanlar3;

--VIEW oluşturma
CREATE VIEW sehir_sayisi AS
SELECT marka_id,marka_isim,(SELECT COUNT(DISTINCT sehir) FROM calisanlar3
						    WHERE isyeri=marka_isim) AS sehir_sayisi
FROM markalar;

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin maksimum ve min maaşini listeleyen bir Sorgu yaziniz.
SELECT marka_isim,calisan_sayisi,(SELECT MAX(maas) FROM calisanlar3 WHERE isyeri=marka_isim) AS max_maas,
                                  (SELECT MIN(maas) FROM calisanlar3 WHERE isyeri=marka_isim) AS min_maas
FROM markalar;


--25-EXISTS Cond.

--SELECT * FROM markalar WHERE condition(koşul):T/F
--SELECT * FROM markalar WHERE marka_isim='Vakko';

--EXISTS
--Bir SQL sorgusunda alt sorgunun sonucunun boş olup olmadığını kontrol etmek için kullanılır.
--Eğer alt sorgu sonucu boş değilse, koşul sağlanmış sayılır ve sorgunun geri kalanı işletilir.
--Alt sorgu en az bir satır döndürürse sonucu EXISTS doğrudur.
--Alt sorgunun satır döndürmemesi durumunda, sonuç EXISTS yanlıştır.

CREATE TABLE mart
(	
urun_id int,	
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO mart VALUES (10, 'Mark', 'Honda');
INSERT INTO mart VALUES (20, 'John', 'Toyota');
INSERT INTO mart VALUES (30, 'Amy', 'Ford');
INSERT INTO mart VALUES (20, 'Mark', 'Toyota');
INSERT INTO mart VALUES (10, 'Adam', 'Honda');
INSERT INTO mart VALUES (40, 'John', 'Hyundai');
INSERT INTO mart VALUES (20, 'Eddie', 'Toyota');

CREATE TABLE nisan 
(	
urun_id int ,
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO nisan VALUES (10, 'Hasan', 'Honda');
INSERT INTO nisan VALUES (10, 'Kemal', 'Honda');
INSERT INTO nisan VALUES (20, 'Ayse', 'Toyota');
INSERT INTO nisan VALUES (50, 'Yasar', 'Volvo');
INSERT INTO nisan VALUES (20, 'Mine', 'Toyota');

select * from mart;
select * from nisan;

--Mart ayında 'Toyota' satışı yapılmışsa Nisan ayındaki tüm ürünlerin bilgilerini listeleyiniz.

SELECT * 
FROM nisan
WHERE EXISTS (SELECT urun_isim FROM mart WHERE urun_isim='Toyota'); 

--EXISTS false olursa
--Mart ayında 'Volvo' satışı yapılmışsa Nisan ayındaki tüm ürünlerin bilgilerini listeleyiniz.

SELECT * 
FROM nisan
WHERE EXISTS (SELECT urun_isim FROM mart WHERE urun_isim='Volvo');

--Mart ayında satılan ürünün urun_id ve musteri_isim'lerini, eğer Nisan ayında da satılmışsa, listeleyen bir sorgu yazınız. 

SELECT urun_id,musteri_isim
FROM mart 
WHERE EXISTS (SELECT urun_isim FROM nisan WHERE nisan.urun_isim=mart.urun_isim )

SELECT urun_id,musteri_isim,urun_isim
FROM mart AS m
WHERE EXISTS (SELECT urun_isim FROM nisan AS n WHERE n.urun_isim=m.urun_isim )--correlated subquery

---Her iki ayda birden satılan ürünlerin URUN_ISIM'lerini ve bu ürünleri
--NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız

SELECT urun_isim, musteri_isim
FROM nisan AS n
WHERE EXISTS (SELECT urun_isim FROM mart AS m WHERE m.urun_isim=n.urun_isim )


--Martta satılıp Nisanda satilmayan ürünlerin URUN_ISIM'lerini ve bu ürünleri
--MART ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.

SELECT urun_isim,musteri_isim
FROM mart 
WHERE NOT EXISTS (SELECT urun_isim FROM nisan WHERE nisan.urun_isim=mart.urun_isim )

/*-------- ÖDEV --------
1.Soru: Bir "Orders" tablosu düşünelim. Bu tabloda müşterilere ait sipariş bilgileri bulunmaktadır. Tabloda aşağıdaki alanlar yer almaktadır:
order_id (sipariş numarası)
customer_id (müşteri numarası)
order_date (sipariş tarihi)
total_amount (toplam tutar)
Bu tablodan, toplam tutarı en yüksek olan müşteriyi bulmak için bir SQL sorgusu yazın. Subquery (alt sorgu) kullanarak toplam tutarı en yüksek olan müşteriyi belirleyin.

2.Soru: Bir "Employees" tablosu düşünelim. Bu tabloda şirkette çalışanlara ait bilgiler bulunmaktadır. Tabloda aşağıdaki alanlar yer almaktadır:
employee_id (çalışan numarası)
employee_name (çalışan adı)
department_id (departman numarası)
salary (çalışanın maaşı)
Bu tablodan her departmandaki en yüksek maaşlı çalışanları bulmak için bir SQL sorgusu yazın. Subquery (alt sorgu) kullanarak her departmandaki en yüksek maaşlı çalışanları belirleyin.

3.Soru: Bir "Products" tablosu düşünelim. Bu tabloda ürünlere ait bilgiler bulunmaktadır. Tabloda aşağıdaki alanlar yer almaktadır:
product_id (ürün numarası)
product_name (ürün adı)
category (ürün kategorisi)
price (ürün fiyatı)
stock_quantity (stok miktarı)
Bu tablodan her kategorideki en düşük fiyatlı ürünleri bulmak için bir SQL sorgusu yazın. Subquery (alt sorgu) kullanarak her kategorideki en düşük fiyatlı ürünleri belirleyin.

4.Soru: Bir "Customers" tablosu düşünelim. Bu tabloda müşterilere ait bilgiler bulunmaktadır. Tabloda aşağıdaki alanlar yer almaktadır:
customer_id (müşteri numarası)
customer_name (müşteri adı)
city (şehir)
Bu tablodan belirli bir şehirdeki müşterilerin, bu şehirdeki diğer müşterilerin sayısını içeren bir rapor elde etmek için bir SQL sorgusu yazın. Subquery (alt sorgu) kullanarak belirli bir şehirdeki müşterilerin sayısını bulun.
*/