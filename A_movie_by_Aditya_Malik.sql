-- PART A assessment

-- 1. List the titles of all movies directed by 'Hitchcock'

select mov_title from movie
join movie_direction
on movie_direction.mov_id = movie.mov_id
join director
on movie_direction.dir_id = director.dir_id
where dir_fname = "Hitchcock";

-- 2. Find the movie names where one or more actors acted in two or more movies

select mov_title from movie
where mov_id in (
select mov_id from movie_cast
where act_id in (
select act_id from actor
where act_id in (
select act_id
from movie_cast group by act_id
having count(act_id)>1)));

-- 3. List all actors who acted in a movie before 2000 and also in a movie after 2015 (use join operation)

select * from actor
join movie_cast
on actor.act_id = movie_cast.act_id
join movie
on movie_cast.mov_id = movie.mov_id
where mov_year not between 2000 and 2015;

-- 4. find the title of movies and number of stars for each movie that has at least one rating and find the highest number of stars that movie recived. sort the result by movie title

select mov_title, max(rev_stars)
from movie
inner join rating
where rating.mov_id = movie.mov_id
group by mov_title
having max(rev_stars) > 0
order by mov_title;

-- 5. Update rating of all movies directed by 'Steven Spielberg' to 5

update rating
join movies
on movies.mov_id = rating.mov_id
join director
on director.dir_id = movies.mov_id
set rev_star = 5
where dir_name = "Steven Spielberg";