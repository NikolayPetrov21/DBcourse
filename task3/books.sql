create table student13.book_writers 
	(id int4 primary key,
	full_name text not null, 
	date_of_birth date
	);
	
create table student13.book_genres
	(
	id int2 primary key,
	genre_name text unique not null
	);
	
create table student13.books
	(
	id int4,
	book_name text not null,
	writer_id int4 references book_writers(id) not null,	
	published int2,
	genre_id int2 references book_genres(id),
	downloads int4
	) partition by range (downloads);

select * from student13.book_writers;
select * from student13.book_genres;
select * from student13.books;

--task2
create table student13.low_books partition of student13.books for values from (0) to (1000); 
create table student13.mid_books partition of student13.books for values from (1000) to (10000);
create table student13.high_books partition of student13.books for values from (10000) to (maxvalue);

--task3
insert into student13.book_writers values(1, 'Иван Ефремов', '1908-04-23');
insert into student13.book_writers values(2, 'Антон Чехов', '1860-01-29');
insert into student13.book_writers values(3, 'Джордж Оруэлл', '1903-06-25');

insert into student13.book_genres values(1, 'Научная фантастика');
insert into student13.book_genres values(2, 'Рассказ');
insert into student13.book_genres values(3, 'Антиутопия');
insert into student13.book_genres values(4, 'Заметки');
insert into student13.book_genres values(5, 'Детектив');
insert into student13.book_genres values(6, 'Фэнтези');
insert into student13.book_genres values(7, 'Биография');

insert into student13.books values(1, 'Час Быка', 1, 1968, 1, 500);
insert into student13.books values(2, 'Таис Афинская', 1, 1972, 1, 1500);
insert into student13.books values(3, 'Туманность Андромеды', 1, 1957, 1, 90000);
insert into student13.books values(4, 'Человек в футляре', 2, 1898, 2, 12000);
insert into student13.books values(5, 'О женщинах', 2, 1898, 4, 100);
insert into student13.books values(6, 'Скотный двор', 3, 1945, 3, 7500);
insert into student13.books values(7, '1984', 3, 1949, 3, 250000);
insert into student13.books values(8, 'Дама с собачкой', 2, 1899, 2, 900);

select ctid, * from student13.books;
select ctid, * from student13.book_writers;
select ctid, * from student13.book_genres;

select * from student13.books;
select * from student13.low_books;
select * from student13.mid_books;
select * from student13.high_books;

--task4
create index books_author_index on student13.books (writer_id);

--task5
select sum(downloads) from student13.books b 
left join student13.book_genres bg on b.genre_id = bg.id 
where genre_name = 'Научная фантастика';

--task6
select distinct genre_name, sum(downloads) from student13.books b 
left join student13.book_genres bg on b.genre_id = bg.id
group by genre_name ;

--task7
select full_name, avg(downloads) from student13.books b 
left join student13.book_genres bg on b.genre_id = bg.id
left join student13.book_writers bw on b.writer_id = bw.id 
group by full_name;

--task8
select full_name, sum(downloads) from student13.books b 
left join student13.book_writers bw on b.writer_id = bw.id
group by full_name;

--task9
select full_name, count(book_name) from student13.books b 
left join student13.book_writers bw on b.writer_id = bw.id
group by full_name;

--task10
select * from student13.books b 
full join student13.book_genres bg on b.genre_id = bg.id
full join student13.book_writers bw on b.writer_id = bw.id;

--task11
select distinct genre_name from student13.book_genres bg  
where bg.id not in (select genre_id from student13.books b where genre_id is not null);



--drop table student13.book_writers;
--drop table student13.book_genres;
--drop table student13.books;
	
