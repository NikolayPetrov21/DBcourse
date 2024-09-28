create table student13.countries
	(id int2 primary key,
	country_name text unique not null
	);

create table student13.singers 
	(id int4 primary key,
	full_name text not null, 
	date_of_birth date, 
	country_id int2 references countries(id) not null
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
	views int4,
	genre_id int2 references song_genres(id),
	unique (album_id, track_name)
	);

select * from student13.countries;
select * from student13.singers;
select * from student13.song_genres;
select * from student13.albums;
select * from student13.tracks;

--task2
insert into student13.countries values(1, 'England');
insert into student13.countries values(2, 'USA');
insert into student13.countries values(3, 'Canada');

insert into student13.singers values(1, 'Sting', '1951-10-02', 1);
insert into student13.singers values(2, 'Madonna', '1958-08-16', 2);
insert into student13.singers values(3, 'Elton John', '1947-03-25', 1);
insert into student13.singers values(4, 'Lady Gaga', '1986-03-28', 2);
insert into student13.singers values(5, 'Celine Dion', '1968-03-30', 3);

insert into student13.song_genres values(1, 'Pop');
insert into student13.song_genres values(2, 'Rock');
insert into student13.song_genres values(3, 'Blues');
insert into student13.song_genres values(4, 'Dance');
insert into student13.song_genres values(5, 'Electronic');
insert into student13.song_genres values(6, 'Country');
insert into student13.song_genres values(7, 'Hard Rock');
insert into student13.song_genres values(8, 'Metal');

insert into student13.albums values(1, 2, 'American Life', 2003);
insert into student13.albums values(2, 2, 'Rebel Heart', 2015);
insert into student13.albums values(3, 1, 'Brand New Day', 1999);
insert into student13.albums values(4, 3, 'Made in England', 1995);
insert into student13.albums values(5, 4, 'The Fame Monster', 2009);
insert into student13.albums values(6, 5, 'Let''s Talk About Love', 1997);
insert into student13.albums values(7, 3, 'Sleeping with the Past', 1989);

insert into student13.tracks values(1, 1, 'Holywood', '00:04:23', 13000000, 1);
insert into student13.tracks values(2, 1, 'American Life', '00:04:58', 17000000, 4);
insert into student13.tracks values(3, 2, 'Holy Water', '00:04:09', 750000, 1);
insert into student13.tracks values(4, 3, 'Desert Rose', '00:04:46', 486000000, 1);
insert into student13.tracks values(5, 4, 'Believe', '00:04:39', 750000, 2);
insert into student13.tracks values(6, 4, 'Belfast', '00:06:31', 15000, 1);
insert into student13.tracks values(7, 5, 'Bad Romance', '00:04:55', 1800000000, 4);
insert into student13.tracks values(8, 5, 'Alejandro', '00:04:35', 5000, 1);
insert into student13.tracks values(9, 6, 'My Heart Will Go On', '00:07:22', 88000000, 1);
insert into student13.tracks values(10, 7, 'Sacrifice', '00:05:07', 753000000, 3);

--task3
select distinct full_name, genre_name from student13.tracks t 
left join student13.albums a on t.album_id = a.id 
left join student13.singers s on a.singer_id = s.id 
left join student13.song_genres sg on t.genre_id = sg.id 
where genre_name = 'Dance';

--task4
select distinct full_name from student13.tracks t 
left join student13.albums a on t.album_id = a.id 
left join student13.singers s on a.singer_id = s.id 
left join student13.song_genres sg on t.genre_id = sg.id 
where genre_name != 'Rock';

--task5
select distinct track_name, full_name, duration, views, genre_name from student13.tracks t 
left join student13.albums a on t.album_id = a.id 
left join student13.singers s on a.singer_id = s.id 
left join student13.song_genres sg on t.genre_id = sg.id 
where genre_name = 'Pop' and views > 30000;

--task6
select full_name, avg(views) as count from student13.tracks t 
left join student13.albums a on t.album_id = a.id 
left join student13.singers s on a.singer_id = s.id 
left join student13.song_genres sg on t.genre_id = sg.id 
where genre_name = 'Pop'
group by full_name having avg(views) > 20000000;

--task7
select sum(views) from student13.tracks t 
left join student13.song_genres sg on t.genre_id = sg.id 
where genre_name = 'Pop';

--task8
select genre_name, sum(views) as total_views from student13.tracks t 
left join student13.song_genres sg on t.genre_id = sg.id
group by genre_name
order by total_views desc;

--task9
select full_name, avg(views) as avg_views from student13.tracks t 
left join student13.albums a on t.album_id = a.id 
left join student13.singers s on a.singer_id = s.id 
left join student13.song_genres sg on t.genre_id = sg.id
group by full_name
order by avg_views desc;

--task10
select full_name, sum(views) as total_views from student13.tracks t 
left join student13.albums a on t.album_id = a.id 
left join student13.singers s on a.singer_id = s.id 
left join student13.song_genres sg on t.genre_id = sg.id
group by full_name
order by total_views asc;

--task11
select full_name, count(track_name) from student13.tracks t 
left join student13.albums a on t.album_id = a.id 
left join student13.singers s on a.singer_id = s.id
group by full_name;

--task12
select * from student13.tracks t 
inner join student13.albums a on t.album_id = a.id 
inner join student13.singers s on a.singer_id = s.id;

select * from student13.tracks t 
left outer join student13.albums a on t.album_id = a.id 
left outer join student13.singers s on a.singer_id = s.id;

select * from student13.tracks t 
right outer join student13.albums a on t.album_id = a.id 
right outer join student13.singers s on a.singer_id = s.id;

select * from student13.tracks t 
full join student13.albums a on t.album_id = a.id 
full join student13.singers s on a.singer_id = s.id;

--task13
insert into student13.tracks values(11, 1, 'Intervention', '00:04:54', 385000, null);

select genre_name from student13.song_genres sg  
left join student13.tracks t on t.genre_id = sg.id 
where t.id is null;
--OR--
select distinct genre_name from student13.song_genres sg 
where sg.id not in (select genre_id from student13.tracks t where genre_id is not null);



--drop table student13.countries;
--drop table student13.singers ;
--drop table student13.song_genres;
--drop table student13.albums;
--drop table student13.tracks;
