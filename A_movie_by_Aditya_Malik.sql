use movietest;

CREATE TABLE actor (
    act_id INT  PRIMARY KEY,
   act_name varchar(50),
   act_gender varchar(1)
);

create table director(
dir_id int primary key,
dir_name varchar(20),
dir_phoneno varchar(20)
);

create table movies(
mov_id INT  PRIMARY KEY,
mov_title VARCHAR(50) ,
mov_year INT ,

mov_lang VARCHAR(50),
dir_id int, foreign key (dir_id) references director (dir_id)
);

create table movie_cast(
act_id int references actor(act_id),
mov_id int,
rolem varchar(50),
foreign key (mov_id) references movies(mov_id)
);

create table rating (
mov_id int,
rev_star int,
foreign key(mov_id) references movies (mov_id)
);


insert into actor(act_id,act_name,act_gender)
values
(301,'ANUSHKA','F'),
(302,'PRABHAS','M'),
(303,'PUNITH','M'),
(304,'JERMY','M');


insert into director (dir_id,dir_name,dir_phoneno)
values
(60,'RAJAMOULI','8751611001'),
(61,'HITCHCOCK','7766138911'),
(62,'FARAN', '9986776531'),
(63,'STEVEN SPIELBERG', '8989776530');


insert into movies( mov_id,mov_title,mov_year,mov_lang,dir_id)
values
(1001,'BAHUBALI-2',2017,'TELAGU',60),
(1002,'BAHUBALI-1',2015,'TELAGU',60),
(1003,'AKASH' , '2008','KANNADA',61),
(1004,'WAR HORSE',2011, 'ENGLISH', 63);

insert into  movie_cast (act_id,mov_id,rolem)
values 
(301,1002,'HEROINE'),
(301,1001,'HEROINE'),
(303,1003,'HERO'),
(303,1002,'GUEST'),
(304,1004,'HERO');

insert into rating(mov_id,rev_star)
values 
(1001,4),
(1002,2),
(1003,5),
(1004,4);




-- PART A assessment

-- 1. List the titles of all movies directed by 'Hitchcock'

select mov_title from movies
where dir_id in (select dir_id from director);

-- 2. Find the movie names where one or more actors acted in two or more movies

select mov_title from movies ,movie_cast where movies.mov_id = movie_cast.mov_id and act_id in 
(select act_id from movie_cast group by act_id having  count(act_id)>1)

group by mov_title having count(mov_title)>1;

-- 3. List all actors who acted in a movie before 2000 and also in a movie after 2015 (use join operation)

select act_name from 
actor 
join movie_cast on movie_cast.act_id =  actor.act_id
join movies on movies.mov_id = movie_cast.mov_id
where mov_year<2000 or mov_year>2015;


-- 4. find the title of movies and number of stars for each movie that has at least one rating and find the highest number of stars that movie recived. sort the result by movie title
 select mov_title, max(rev_star) from movies m inner join rating r on
 m.mov_id = r.mov_id group by
 mov_title order by mov_title;


-- 5. Update rating of all movies directed by 'Steven Spielberg' to 5

update rating
join movies
on movies.mov_id = rating.mov_id
join director
on director.dir_id = movies.mov_id
set rev_star = 5
where dir_name = "Steven Spielberg";
