create table student13.singers 
	(id int4 primary key,
	full_name text not null, 
	date_of_birth date, 
	country text
	);

create table student13.song_genres
	(
	id int2 primary key,
	genre_name text unique not null
	);
	
create table student13.albums
	(
	id int4 primary key,
	singer_id int4 references singers(id) not null,
	album_name text,
	year int2,
	unique (singer_id, album_name)
	);

create table student13.tracks
	(
	id int4 primary key,
	album_id int4 references albums(id) not null,
	track_name text not null,
	duration time,
	genre_id int2 references song_genres(id) not null,
	unique (album_id, track_name)
	);
