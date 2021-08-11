
-- Q1  write a sp which returns the number of movies from japan ---
create or replace function sp_count_movies_japan() returns bigint
    language plpgsql as $$
    declare
        count_movies bigint := 0;
    begin
        select count(*) into count_movies
        from movies
        join countries c on movies.country_id = c.id
        where c.name = 'JAPAN';
        return count_movies ;
    end;
    $$;

select *  from sp_count_movies_japan();


-- Q2 write a sp which returns the most cheapest movie --
create or replace function sp_get_most_cheapest_movie_name(out movie_name text, out min_price double precision)
    language plpgsql as $$
    begin
        select min(price) into min_price
        from movies;

        select movies.title into movie_name
        from movies where movies.price = min_price
        limit 1;
    end;
    $$;


select * from sp_get_most_cheapest_movie_name();

-- Q3 write a sp which returns the avg between the most expansive movie price and the most cheapest movie price--

create or replace function sp_get_avg_movie_name_between_exp_che(out movie_name text, out movie_price double precision)
    language plpgsql as $$
     declare
        max_price double precision := 0;
        min_price double precision := 0;
    begin
        select min(price) into min_price
        from movies;

        select max(price) into max_price
        from movies;

        movie_price := (max_price+min_price) / 2;

        select movies.title into movie_name
        from movies where movies.price = movie_price
        limit 1;
    end;
    $$;

select  * from sp_get_avg_movie_name_between_exp_che();

-- Q4 write a sp which gets a parameter above_price and returns the number of movies which costs more than this price (above_price )--

create  or replace function  sp_count_movies_above_price( above_price double precision, out num_of_movies_above_price double precision)
language  plpgsql as $$
    begin
        select count(*) into num_of_movies_above_price
        from movies
        where movies.price > above_price;

    end;
    $$;

select * from sp_count_movies_above_price(50);
