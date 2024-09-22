create table student13.singers 
	(id int4 primary key,
	full_name text not null, 
	date_of_birth date, 
	country text
	);
	
create table student13.tracks
	(
	id int4 primary key,
	track_name text not null,
	duration time
	);

create table student13.song_genres
	(
	id int2 primary key,
	genre_name text unique
	);
	
create table student13.albums
	(
	id int4 primary key,
	singer_id int4 references singers(id) ,
	track_id int4 references tracks(id),
	year int2,
	genre_id int2 references song_genres(id)
	);



