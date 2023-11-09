select * from products;
--1. Product isimlerini (`ProductName`) ve birim başına miktar (`QuantityPerUnit`) değerlerini almak için sorgu yazın.
select product_name, quantity_per_unit from products;

--2. Ürün Numaralarını (`ProductID`) ve Product isimlerini (`ProductName`) değerlerini almak için sorgu yazın. Artık satılmayan ürünleri (`Discontinued`) filtreleyiniz.
select product_id, product_name from products where Discontinued in(0);

--3. Durdurulan Ürün Listesini, Ürün kimliği ve ismi (`ProductID`, `ProductName`) değerleriyle almak için bir sorgu yazın.
select product_id, product_name from products where Discontinued in(1);

--4. Ürünlerin maliyeti 20'dan az olan Ürün listesini (`ProductID`, `ProductName`, `UnitPrice`) almak için bir sorgu yazın.
select  product_id, product_name, unit_price from products where 20>unit_price order by unit_price ASC;

--5. Ürünlerin maliyetinin 15 ile 25 arasında olduğu Ürün listesini (`ProductID`, `ProductName`, `UnitPrice`) almak için bir sorgu yazın.
select  product_id, product_name, unit_price from products where unit_price >20 AND unit_price <25  order by unit_price ASC;

--6. Ürün listesinin (`ProductName`, `UnitsOnOrder`, `UnitsInStock`) stoğun siparişteki miktardan az olduğunu almak için bir sorgu yazın.
select product_name, units_on_order, units_in_stock from products where units_in_stock < units_on_order order by product_name; 

--7. İsmi `a` ile başlayan ürünleri listeleyeniz.
select product_name from products where lower(product_name) like('a%');

--8. İsmi `i` ile biten ürünleri listeleyeniz.
select product_name from products where lower(product_name) like('%i');

--9. Ürün birim fiyatlarına %18’lik KDV ekleyerek listesini almak (ProductName, UnitPrice, UnitPriceKDV) için bir sorgu yazın.
select product_name, b.unit_price, (b.unit_price + b.unit_price * 18/100) AS kdvLiSatisFiyati from products AS b order by kdvLiSatisFiyati ;  

--10. Fiyatı 30 dan büyük kaç ürün var?
select COUNT(*) from products where (unit_price > 30) ;

--11. Ürünlerin adını tamamen küçültüp fiyat sırasına göre tersten listele
select lower(product_name), unit_price from products order by unit_price DESC;

--12. Çalışanların ad ve soyadlarını yanyana gelecek şekilde yazdır
select * from employees;
select CONCAT(first_name, ' ', last_name) AS "FULLName" from employees;

--13. Region alanı NULL olan kaç tedarikçim var?
select * from suppliers;
select company_name, region from suppliers where region is NULL order by company_name;
select COUNT(*) from suppliers where region is NULL;

--14. a.Null olmayanlar?
select COUNT(*) from suppliers where region is not NULL;
select COUNT(*) from suppliers where length(region)>0;

--15. Ürün adlarının hepsinin soluna TR koy ve büyültüp olarak ekrana yazdır.
select 'TR ' || UPPER(product_name) AS ProductName from products;

--16. a.Fiyatı 20den küçük ürünlerin adının başına TR ekle
select 'TR ' || UPPER(product_name) AS ProductName from products where unit_price < 20

--17. En pahalı ürün listesini (`ProductName` , `UnitPrice`) almak için bir sorgu yazın.
select product_name,unit_price from products order by unit_price DESC limit 1;

--18. En pahalı on ürünün Ürün listesini (`ProductName` , `UnitPrice`) almak için bir sorgu yazın.
select product_name,unit_price from products order by unit_price DESC limit 10;

--19. Ürünlerin ortalama fiyatının üzerindeki Ürün listesini (`ProductName` , `UnitPrice`) almak için bir sorgu yazın.
select product_name, unit_price from products where unit_price >(Select AVG(unit_price) from products) ;

--20. Stokta olan ürünler satıldığında elde edilen miktar ne kadardır.
Select SUM(units_in_stock*unit_price) as total from products;

--21. Mevcut ve Durdurulan ürünlerin sayılarını almak için bir sorgu yazın.
Select COUNT(*) from products where Discontinued = 1 AND units_in_stock > 0;

--22. Ürünleri kategori isimleriyle birlikte almak için bir sorgu yazın.
select products.product_name, categories.category_name from products join categories on products.category_id = categories.category_id order by categories.category_name; 

--23. Ürünlerin kategorilerine göre fiyat ortalamasını almak için bir sorgu yazın.
select categories.category_name, AVG(products.unit_price) as avarage_price_as_group_by_categories from products 
join categories on products.category_id = categories.category_id group by categories.category_name; 

--24. En pahalı ürünümün adı, fiyatı ve kategorisin adı nedir?
select products.product_name as mostExpensiveProduct , products.unit_price, categories.category_name from products 
join categories on products.category_id = categories.category_id ORDER by Products.Unit_Price DESC LIMIT 1; 

--25. En çok satılan ürününün adı, kategorisinin adı ve tedarikçisinin adı
select products.product_name, products.units_on_order, categories.category_name, suppliers.company_name from products 
join categories on products.category_id = categories.category_id 
join suppliers on products.supplier_id = suppliers.supplier_id 
order by products.units_on_order DESC limit 1;
