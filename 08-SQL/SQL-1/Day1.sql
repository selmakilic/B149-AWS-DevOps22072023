-------- SQL 1 --------

-- 1- Yorum Satırı

-- 2- Database Oluşturma - DDL
CREATE DATABASE ms; -- SQL komutlarında case sensitive yoktur ancak değer atamalarında vardır.

-- 3- Database Silme - DDL
DROP DATABASE ms; -- Silme işleminin yapılabilmesi için Database' den Disconnect yapılması ve sorgu ekranının kapatılması gerekmektedir.

-- 4- Tablo Oluşturma - DDL
CREATE TABLE students(
	id CHAR(4),
	name VARCHAR(50),
	grade REAL,
	register_date DATE
); 
-- ; kullanmak zorunda değiliz. Birden fazla komutu çalıştırmak istediğinizde sorgunun bittiği 
-- yeri belirtmek için kullanılır. Daha readable bir yapı kavuşturmak istediğiniz zamanda bunu kullanabilirsiniz.

-- 5- Var olan bir tablodan yeni bir tablo oluşturma
CREATE TABLE grades as SELECT name, grade FROM students; -- Sadece isim ve notları tutan bir tablo yapıldı.

-- 6- Tablo içine veri ekleme - DML
INSERT INTO students VALUES ('1000','Ali', 92.8, '2021-01-01');
INSERT INTO students VALUES ('1001','Veli', 81, '2022-10-08');
INSERT INTO students VALUES ('1002','Kerem', 100, now());
-- Bir çok Komut seçerekde Execute edebilirsiniz. Bunun için ; kullanılması gerekmektedir.

-- 7- Tablonın bazı sütunlarına veri ekleme - DML
INSERT INTO students(name,grade) VALUES ('Aslı', 87);

-- 8- Tablonun tüm kayıtlarını getirme
SELECT * FROM students;

-- 9- Tablonun bazı kayıtlarını getirme
SELECT name,grade FROM students;

/*-------- ÖDEV --------
1) Tablo Oluşturma
"tedarikciler" isminde bir tablo olusturun,
"tedarikci_id", "tedarikci_ismi", "tedarikci_adres"
ve "ulasim_tarihi"	field'lari olsun. 

2) Var olan tablodan yeni tablo olusturmak 
 "tedarikci_info" isminde bir tabloyu  "tedarikciler" tablosundan olusturun.
Icinde "tedarikci_ismi", "ulasim_tarihi" field'lari olsun

3) Data ekleme
" ogretmenler" isminde tablo olusturun.
 Icinde "kimlik_no", "isim", "brans" ve "cinsiyet" field'lari olsun.
"ogretmenler" tablosuna bilgileri asagidaki gibi olan kisileri ekleyin.
kimlik_no: 234431223, isim: Nana TechWorld, brans : DevOps, cinsiyet: kadin.
kimlik_no: 234431224, isim: Mehmet Ince, brans : Security, cinsiyet: erkek.

4) Bazı fieldları olan kayıt ekleme
"ogretmenler" tablosuna bilgileri asagidaki gibi olan bir kisi ekleyin.
kimlik_no: 567597624, isim: Stephane Maarek
*/