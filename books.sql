create table student13.book_writers 
	(id int4 primary key,
	full_name text not null, 
	date_of_birth date, 
	country text
	);
	
create table student13.book_genres
	(
	id int2 primary key,
	genre_name text unique not null
	);
	
create table student13.books
	(
	id int4 primary key,
	writer_id int4 references book_writers(id) not null,
	book_name text not null,
	published int2,
	genre_id int2 references book_genres(id) not null,
	unique (writer_id, book_name)
	);