/* functions and procedures */
/* 1 */
create or replace procedure add_new_player(name VARCHAR, surname varchar, age int)
    as
    $$
    declare
        player_id int := (select id+1 from person order by id desc limit 1);
        role_id int := (select id from role where role.name = 'Player');
    begin
        insert into person values (player_id, name, surname, age, false, role_id);
    end;
    $$
    language 'plpgsql';

create or replace procedure add_new_org(name VARCHAR, surname varchar, age int)
    as
    $$
    declare
        org_id int := (select id+1 from person order by id desc limit 1);
        role_id int := (select id from role where role.name = 'Organizator');
    begin
        insert into person values (org_id, name, surname, age, null, role_id);
    end;
    $$
    language 'plpgsql';

create or replace procedure add_new_arb(name VARCHAR, surname varchar, age int)
    as
    $$
    declare
        arb_id int := (select id+1 from person order by id desc limit 1);
        role_id int := (select id from role where role.name = 'Arbitr');
    begin
        insert into person values (arb_id, name, surname, age, null, role_id);
    end;
    $$
    language 'plpgsql';

create or replace procedure add_new_staff(name VARCHAR, surname varchar, age int)
    as
    $$
    declare
        staff_id int := (select id+1 from person order by id desc limit 1);
        role_id int := (select id from role where role.name = 'Staff');
    begin
        insert into person values (staff_id, name, surname, age, null, role_id);
    end;
    $$
    language 'plpgsql';



/* 2 */
create or replace procedure send_invite(org_id integer, player_id integer, comp_info text, tournament_id integer)
    as
    $$
    declare
        cur_id int = (select id+1 from invite order by id desc limit 1);
        cur_date date = (select current_date);
        date_to_response date = (select cast(TO_CHAR((SELECT current_date + (interval '1 month')), 'YYYY-MM-DD') as date));

    begin
        insert into invite values (cur_id, comp_info, cur_date, date_to_response, org_id, player_id, tournament_id);
    end;
    $$
    language 'plpgsql';



/* 3 */
create or replace procedure get_response(org_id integer, player_id integer, answer text, tournament_id integer)
    as
    $$
    declare
        cur_id int = (select id+1 from response order by id desc limit 1);
        cur_date date = (select current_date);

    begin
        insert into response values (cur_id, answer, cur_date, org_id, player_id, tournament_id);
    end;
    $$
    language 'plpgsql';



/* 4 */
create or replace procedure get_entrance_fee(org_id integer, player_id integer, money int, tournament_id integer)
    as
    $$
    declare
        cur_id int = (select id+1 from entrance_fee order by id desc limit 1);
    begin
        insert into entrance_fee values (cur_id, money, org_id, player_id, tournament_id);
    end;
    $$
    language 'plpgsql';



/* 5 */
create or replace procedure register_player(player_id int, tournament_id int)
    as
    $$
    begin
      update person set has_accepted = true where id = player_id;
      insert into tournament_person values (tournament_id, player_id);
    end;
    $$
    language 'plpgsql';




/* 6 */
create or replace function show_all_players(t_id int)
    returns table(
        player_id int,
        name varchar,
        surname varchar,
        age int,
        role varchar,
        tournament varchar,
        tournament_description text
    )
    as
    $$
    begin
        return query
        select p.id, p.name, p.surname, p.age, r.name, t.name, t.description
        from person p join tournament_person tp on p.id = tp.person_id
        join tournament t on t.id = tp.tournament_id
        join role r on r.id = p.role_id
        where t.id = t_id and r.name = 'Player';

    end;
    $$
    language 'plpgsql';

select p.id, p.name, p.surname, p.age, r.name, t.name, t.description from person p join tournament_person tp on p.id = tp.person_id join tournament t on t.id = tp.tournament_id join role r on r.id = p.role_id where t.id = 1 and r.name = 'Player';



/* 7 */
create or replace function show_all_in_time_responses(t_id int)
    returns table(
        response_id int,
        answer text,
        player_id int,
        player_name varchar,
        player_surname varchar
        )
    as
    $$
    begin
        return query
        select r.id, r.answer, p.id, p.name, p.surname
        from response r join person p on r.player_id = p.id
        join invite i on i.player_id = p.id
        where r.tournament_id = t_id and r.send_date <= i.date_to_response;
    end;
    $$
    language 'plpgsql';

select r.id, r.answer, p.id, p.name, p.surname from response r join person p on r.player_id = p.id join invite i on i.player_id = p.id
         where r.tournament_id = 1 and r.send_date <= i.date_to_response;



/* 8 */
create or replace procedure create_game(p1_id int, p2_id int, a_id int, t_id int, tr int)
    as
    $$
    declare
        cur_id int = (select id+1 from game order by id desc limit 1);
        cur_date date := (select current_date);
    begin
        insert into game values (cur_id, p1_id, p2_id, a_id, t_id, null, tr, cur_date);
    end;
    $$
    language 'plpgsql';


/* 9 */
create or replace function show_tournament_schedule(t_id int)
    returns table(
        game_id int,
        first_name varchar,
        first_surname varchar,
        second_name varchar,
        second_surname varchar,
        start_date date
    )
    as
    $$
    begin
        return query
        select g.id, p1.name, p1.surname, p2.name, p2.surname, g.start_date
        from tournament t join game g on t.id = g.tournament_id
        join person p1 on p1.id=g.player1_id join
        person p2 on p2.id = g.player2_id where t.id = t_id;
    end;
    $$
    language 'plpgsql';

select g.id, p1.name, p1.surname, p2.name, p2.surname, g.start_date from tournament t join game g on t.id = g.tournament_id join person p1 on p1.id=g.player1_id join person p2 on p2.id = g.player2_id where t.id = 1;



/* 10 */
create or replace function show_player_schedule(t_id int, p_id int)
    returns table(
        game_id int,
        first_name varchar,
        first_surname varchar,
        second_name varchar,
        second_surname varchar,
        start_date date
    )
    as
    $$
    begin
        return query
        select g.id, p1.name, p1.surname, p2.name, p2.surname, g.start_date
        from tournament t join game g on t.id = g.tournament_id
        join person p1 on p1.id=g.player1_id join
        person p2 on p2.id = g.player2_id where t.id = t_id
        and (p1.id = p_id or p2.id = p_id) order by g.tour;
    end;
    $$
    language 'plpgsql';



/* 11 */
/* result: 0 - first player win, 1 - draw, 2 - second player win */
create or replace procedure calculate_game_result(g_id int, res int)
    as
    $$
    declare
        p1_id int := (select player1_id from game where id = g_id);
        p2_id int := (select player2_id from game where id = g_id);
    begin
        if res > 2 or res < 0
            then
                raise exception 'result: 0 - first player win, 1 - draw, 2 - second player win, % - is not an option', res;
        elseif res = 0
            then
                update game set result = res where id = g_id;
                update score set score = score+1 where player_id = p1_id;
        elseif res = 2
            then
                update game set result = res where id = g_id;
                update score set score = score+1 where player_id = p2_id;
        else
                update game set result = res where id = g_id;
                update score set score = score+0.5 where player_id = p1_id;
                update score set score = score+0.5 where player_id = p2_id;
        end if;
    end;
    $$
    language 'plpgsql';



/* 12 */
create or replace function show_players_scores(t_id int)
    returns table(
        score_id int,
        player_name varchar,
        player_surname varchar,
        score decimal
    )
    as
    $$
    begin
        return query
        select s.id, p.name, p.surname, s.score
        from score s join tournament t on s.tournament_id=t.id
        join person p on p.id = s.player_id
        where t.id = 1 order by s.score desc;
    end;
    $$
    language 'plpgsql';

select s.id, p.name, p.surname, s.score from score s join tournament t on s.tournament_id=t.id join person p on p.id = s.player_id where t.id = 1 order by s.score desc;



/* 13 */
create or replace procedure set_responsible_for_game(staff_id int, game_id int)
    as
    $$
    declare
        tgame_id int = (select t.id from tournament t join game g on t.id = g.tournament_id where g.id = game_id);
        tstaff_id int = (select t.id from tournament t join tournament_person tp on t.id = tp.tournament_id join person p on p.id = tp.person_id where p.id = staff_id);
    begin
        if tgame_id = tstaff_id
        then
            insert into game_staff values (game_id, staff_id);
        else
            raise exception 'Staff and game are in different tournaments';
        end if;
    end;
    $$
    language 'plpgsql';



/* 14 */
create or replace function show_inventory_history()
    returns table(
        inv_id int,
        inv_label varchar,
        how_much_tournaments bigint
    )
    as
    $$
    begin
        return query
        select i.id, i.name, count(*)
        from inventory i join tournament_inventory ti on i.id = ti.inventory_id
        join tournament t on ti.tournament_id = t.id
        group by i.id, i.name order by i.id;
    end;
    $$
    language 'plpgsql';



