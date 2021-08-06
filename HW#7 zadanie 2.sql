select products.name as product, catalogs.name as type from products 
inner join catalogs on catalogs.id = products.catalog_id ;


select products.name, (select catalogs.name from catalogs where catalogs.id = products.catalog_id) as type
	from products;