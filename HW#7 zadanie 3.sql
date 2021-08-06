select f.id, cities_from.name, cities_to.name from flights as f
	inner join cities as cities_from on 
		cities_from.label = f.from 
	inner join cities as cities_to on
		cities_to.label = f.to order by f.id;
		
	
