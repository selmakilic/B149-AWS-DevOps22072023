-------- SQL 2 --------
-- TEKRAR
CREATE TABLE sairler(
	id INT,
	name VARCHAR(50),
	email VARCHAR(50)
);

INSERT INTO sairler VALUES(
	1001,
	'Can Yucel',
	'sair@gmail.com'
);

SELECT * FROM sairler;

INSERT INTO sairler VALUES(
	1002,
	'Ismet Ozel',
	'sair@gmail.com'
);

-- Empty ie null aynı şey değildir. '' kabul edilir.
-- '' da kabul etmemesini isterseniz ilerleyen konularda gösterilecektir.
INSERT INTO sairler VALUES(
	1003,
	'',
	'sair@gmail.com'
);

-- Sadece bazı field' ları girme
INSERT INTO sairler(name) VALUES(
	'Nazim Hikmet'
);

--10-Tabloya UNIQUE Constraint'i Ekleme
CREATE TABLE developers(
	id SERIAL, -- SERIAL: Otomatik sıralı bir şekilde veri giriş yapar.
	name VARCHAR(50),
	email VARCHAR(50) UNIQUE, -- UNIQUE: Tabloda aynı sütun içinde verinin eşsiz olmasını sağlar.
	salary REAL, -- REAL: Ondalık sayı girişinde kullanılır.
	prog_lang VARCHAR(20)
);

SELECT * FROM developers;

INSERT INTO developers(name, email, salary, prog_lang) VALUES(
	'Ahmet',
	'dev@email.com',
	5000,
	'Java'
);

-- Email kolonu aynı olamaz.
INSERT INTO developers(name, email, salary, prog_lang) VALUES(
	'Mehmet',
	'devops@email.com',
	3500,
	'Python'
);

INSERT INTO developers(email, salary, prog_lang) VALUES(
	'security@email.com',
	4200,
	'.NET'
);

--11-Tabloya NOT NULL Constraint'i Ekleme
CREATE TABLE doctors(
	id SERIAL,
	name VARCHAR(50) NOT NULL, -- NOT NULL: Tablodaki verinin değer atamasını zorunlu kılar.
	email VARCHAR(50) UNIQUE,
	salary REAL
);

SELECT * FROM doctors;

INSERT INTO doctors(name, email, salary) VALUES(
	'Dr. Gregory House',
	'dr@email.com',
	6400
);

-- name NOT NULL tanımlandığı için boş olamaz.
INSERT INTO doctors(name, email, salary) VALUES(
	'Alex',
	'dr1@email.com',
	8000
);

-- Empty ile Null birbirinden farklı değerlerdir. Empty yapılabilir.
INSERT INTO doctors(name, email, salary) VALUES(
	'',
	'dr2@email.com',
	9000
);

-- 12-PK Constraint' i Ekleme
CREATE TABLE students2(
	id INT PRIMARY KEY, --NOT NULL, UNIGUE, Başka bir tablo ile ilişki kurmak için kullanılacaktır.
	name VARCHAR(50),
	grade REAL,
	register_date DATE
);

SELECT * FROM students2;
-- PK Constraint'ine DİKKAT!

-- 12-PK Constraint' i Ekleme (2. Yöntem)
CREATE TABLE students3(
	id INT,
	name VARCHAR(50) NOT NULL,
	grade REAL,
	register_date DATE,
	CONSTRAINT std_pk PRIMARY KEY(id)
);

SELECT * FROM students3;
-- Eğer PK' ye özel bir isim verilmek istenirse bu yöntem kullanılır.
-- Birden fazla sütunu bir araya getirerek bir sütun oluşturup PK yapmak için de bu yöntem kullanılır. (Composite Key)

-- Composite Key Kullanımı
CREATE TABLE students4(
	id INT,
	name VARCHAR(50) NOT NULL,
	grade REAL,
	register_date DATE,
	CONSTRAINT std4_pk PRIMARY KEY(id, name) -- Birden fazla field PK olarak belirlenebilir.
);

SELECT * FROM students4;
-- Constraint' leri görüntülemek için Table->Properties da denebilir.
-- NOT NULL kullanımı Table->Properties içinde PostgreSQL göstermez.

-- 13-FK Constraint' i Ekleme (students3-address3)
CREATE TABLE address3(
	address_id INT,
	street VARCHAR(50),
	city VARCHAR(50),
	student_id INT, --FK, NULL Kabul EDER, DUPLICATE KABUL EDER.
	CONSTRAINT add_fk FOREIGN KEY(student_id) REFERENCES students3(id)
);

SELECT * FROM address3;

-- 14-CHECK Constraint' i Ekleme
CREATE TABLE personel(
	id INT,
	name VARCHAR(50) NOT NULL CHECK(name <> ''), -- <> : not equals
	salary REAL CHECK(salary>5000), -- 5000 altı KABUL ETMEZ. 
	age INT CHECK(age>0) -- negatif KABUL ETMEZ.
);

INSERT INTO personel VALUES(1,'',100000,25);
-- name <> '' olduğundan dolayı sorgu hatalı olur.

INSERT INTO personel VALUES(1,'A',1000,25);
-- salary>5000 olduğundan dolayı sorgu hatalı olur.

INSERT INTO personel VALUES(1,'A',10000,-5);
-- age>0 olduğundan dolayı sorgu hatalı olur.

INSERT INTO personel VALUES(1,'A',10000,25);
-- Tüm kısıtlamalar uyduğu için doğru olur.

SELECT * FROM personel;

/*-------- ÖDEV --------
1. Soru:
Bir üniversitenin öğrenci bilgilerini tutmak için "students" adında bir tablo oluşturmanız gerekiyor. Bu tabloda "student_id" (öğrenci numarası), "student_name" (öğrenci adı), "age" (yaş) ve "department" (bölüm) sütunları bulunmalıdır. Sütunlarda aşağıdaki kısıtlamaları uygulayın:
"student_id" sütunu için benzersizlik kısıtlaması (unique constraint) uygulayın.
"student_name" sütunu için boş değer kabul etmeyen kısıtlama (not null constraint) uygulayın.
"age" sütunu için değer aralığı kısıtlaması (check constraint) uygulayın: Yaş değeri 18' den büyük olmalıdır.

2.Soru:
Bir müşterilere ait sipariş bilgilerini tutmak için "orders" adında bir tablo oluşturmanız gerekiyor. Bu tabloda "order_id" (sipariş numarası), "customer_id" (müşteri numarası), "order_date" (sipariş tarihi) ve "total_amount" (toplam tutar) sütunları bulunmalıdır. Sütunlarda aşağıdaki kısıtlamaları uygulayın:
"order_id" sütunu için benzersizlik kısıtlaması (unique constraint) uygulayın.
"customer_id" sütunu için boş değer kabul etmeyen kısıtlama (not null constraint) uygulayın.
"order_date" sütunu için geçerli bir tarih değeri kabul eden kısıtlama (check constraint) uygulayın: Sipariş tarihi bugünden önce olmalıdır.
"total_amount" sütunu için pozitif değer kabul eden kısıtlama (check constraint) uygulayın: Toplam tutar sıfırdan büyük olmalıdır.

3.Soru:
Bir "Students" tablosu ve bir de "Courses" tablosu düşünelim. "Students" tablosunda öğrencilere ait bilgiler bulunurken, "Courses" tablosunda öğrencilerin aldığı derslere ait bilgiler tutuluyor. Tablolarda aşağıdaki alanlar yer alıyor:
Students Tablosu: student_id (öğrenci numarası), student_name (öğrenci adı), department (bölüm)
Courses Tablosu: course_id (ders numarası), course_name (ders adı), credit (kredi), instructor (öğretmen adı)
Bu iki tablo arasında bir ilişki kurmak için hangi anahtar (key) türlerini kullanırsınız?

4.Soru:
Bir "Departments" tablosu ve bir de "Employees" tablosu düşünelim. "Departments" tablosunda şirketin departmanlarına ait bilgiler bulunurken, "Employees" tablosunda çalışanlara ait bilgiler tutuluyor. Tablolarda aşağıdaki alanlar yer alıyor:
Departments Tablosu: department_id (departman numarası), department_name (departman adı), location (yer)
Employees Tablosu: employee_id (çalışan numarası), employee_name (çalışan adı), department_id (departman numarası)
Bu iki tablo arasında bir ilişki kurmak için hangi anahtar (key) türlerini kullanırsınız?

5.Soru:
Bir "Books" tablosu ve bir de "Authors" tablosu düşünelim. "Books" tablosunda kitaplara ait bilgiler bulunurken, "Authors" tablosunda yazarlara ait bilgiler tutuluyor. Tablolarda aşağıdaki alanlar yer alıyor:
Books Tablosu: book_id (kitap numarası), book_name (kitap adı), author_id (yazar numarası)
Authors Tablosu: author_id (yazar numarası), author_name (yazar adı), nationality (uyruk)
Bu iki tablo arasında bir ilişki kurmak için hangi anahtar (key) türlerini kullanırsınız?
*/