/* triggers */
/* 1 2 */
create or replace function check_invite_sending_funk() returns trigger
    as
    $$
    declare
        current_player_id int := new.player_id;
        current_org_id int := new.org_id;
    begin
        if (select role.name from person join role on person.role_id = role.id where person.id = current_player_id) != 'Player'
            then
                raise exception 'Invite could be send only to players!';
        elseif (select role.name from person join role on person.role_id = role.id where person.id = current_org_id) != 'Organizator'
            then
                raise exception 'Invite could be send only by organizators!';
        end if;
        return new;
    end;
    $$
    language 'plpgsql';

create or replace trigger check_invite_sending
    before insert or update on invite
    for each row
    execute function check_invite_sending_funk();

insert into invite(id, competition_info, send_date, date_to_response, org_id, player_id, tournament_id) values
                                            (8000, 'mdqwceeatpfbounqysnypieburnvgpyjvwsnhnaroxngvjesurgz', '2020-07-01', '2020-08-01', 5001, 1, 1);

select * from invite where id = 8000;

delete from invite where id = 8000;



/* 3 4 */
create or replace function check_response_handling_funk() returns trigger
    as
    $$
    declare
        current_player_id int := new.player_id;
        current_org_id int := new.org_id;
    begin
        if (select role.name from role join person p on role.id = p.role_id where p.id = current_player_id) != 'Player'
            then
                raise exception 'Only players could give responses!';
        elseif (select role.name from role join person p2 on role.id = p2.role_id where p2.id = current_org_id) != 'Organizator'
            then
                raise exception 'Only organizators could receive responses!';
        end if;
        return new;
    end;
    $$
    language 'plpgsql';

create or replace trigger check_response_handling
    before insert or update on response
    for each row
    execute function check_response_handling_funk();

insert into response(id, answer, send_date, org_id, player_id, tournament_id) values
                                            (10000, 'YES', '2020-07-07', 1, 1, 1);

select * from response where id = 10000;

delete from response where id = 10000;



/* 5 6 */
create or replace function check_entrance_fee_handling_funk() returns trigger
    as
    $$
    declare
        current_player_id int := new.player_id;
        current_org_id int := new.org_id;
    begin
        if (select role.name from role join person p on role.id = p.role_id where p.id = current_player_id) != 'Player'
            then
                raise exception 'Only players could pay entrance fees!';
        elseif (select role.name from role join person p2 on role.id = p2.role_id where p2.id = current_org_id) != 'Organizator'
            then
                raise exception 'Only organizators could receive entance fees!';
        end if;
        return new;
    end;
    $$
    language 'plpgsql';

create or replace trigger check_entrance_fee_handling
    before insert or update on entrance_fee
    for each row
    execute function check_entrance_fee_handling_funk();

insert into entrance_fee(id, money, org_id, player_id, tournament_id) VALUES
                                            (10000, 300, 1, 1, 1);

select * from entrance_fee where id = 10000;

delete from entrance_fee where id = 10000;


/* 7 */
create or replace function check_game_participants_funk() returns trigger
    as
    $$
    declare
        first_player_id int := new.player1_id;
        second_player_id int := new.player2_id;
    begin
        if (select r.name from person join role r on person.role_id = r.id where person.id = first_player_id) != 'Player'
            then
                raise exception 'First person is not a player!';
        elseif (select r.name from person join role r on person.role_id = r.id where person.id = second_player_id) != 'Player'
            then
                raise exception 'Second person is not a player!';
        elseif first_player_id = second_player_id
            then
                raise exception 'Player can not play with himself!';
        end if;
        return new;
    end;
    $$
    language 'plpgsql';

create or replace trigger check_game_participants
    before insert or update on game
    for each row
    execute function check_game_participants_funk();

insert into game(id, player1_id, player2_id, arb_id, tournament_id, result, tour, start_date) VALUES
                                        (10000, 1, 1, 5027, 1, 0, 1, '2020-09-05');

select * from game where id = 10000;

delete from game where id = 10000;



/* 8 */
create or replace function check_game_observer_funk() returns trigger
    as
    $$
    declare
        arbitr_id int := new.arb_id;
    begin
        if (select r.name from person join role r on person.role_id = r.id where person.id = arbitr_id) != 'Arbitr'
            then
                raise exception 'Only arbitres could observe games!';
        end if;
        return new;
    end;
    $$
    language 'plpgsql';

create or replace trigger check_game_observer
    before insert or update on game
    for each row
    execute function check_game_observer_funk();

insert into game(id, player1_id, player2_id, arb_id, tournament_id, result, tour, start_date) VALUES
                                        (10000, 1, 2, 6, 1, 0, 1, '2020-09-05');

select * from game where id = 10000;

delete from game where id = 10000;



/* 9 */
create or replace function check_game_preparators_funk() returns trigger
    as
    $$
    declare
        staff_id int := new.staff_id;
    begin
        if (select r.name from person join role r on person.role_id = r.id where person.id = staff_id) != 'Staff'
            then
                raise exception 'Only staff could prepare games!';
        end if;
        return new;
    end;
    $$
    language 'plpgsql';

create or replace trigger check_game_preparators
    before insert or update on game_staff
    for each row
    execute function check_game_preparators_funk();

insert into game_staff(game_id, staff_id) values
                                              (1, 1);

select * from game_staff where game_id = 1 and staff_id = 1;

delete from game_staff where game_id = 1 and staff_id = 1;

/* 10 */
create or replace function check_inventory_responsible_funk() returns trigger
    as
    $$
    declare
        staff_id int := new.staff_id;
    begin
        if (select r.name from person join role r on person.role_id = r.id where person.id = staff_id) != 'Staff'
            then
                raise exception 'Only staff could prepare games!';
        end if;
        return new;
    end;
    $$
    language 'plpgsql';

create or replace trigger check_inventory_responsible
    before insert or update on inventory
    for each row
    execute function check_inventory_responsible_funk();

insert into inventory(id, name, description, staff_id) VALUES
                                            (10000, 'Chair', 'To sit on', 1);

select * from inventory where id = 10000;

delete from inventory where id = 10000;



/* 11 */
create or replace function check_player_flag_funk() returns trigger
    as
    $$
    declare
        role_id int := new.role_id;
    begin
        if (select role.name from role where role.id = role_id) = 'Player'
            and new.has_accepted IS NULL
            then
                raise exception 'Players must have non-null has_accepted attribute';
        elseif (select role.name from role where role.id = role_id) != 'Player'
            and new.has_accepted IS NOT NULL
            then
                raise exception 'Non-players must have null has_accepted atttribute';
        end if;
        return new;
    end;
    $$
    language 'plpgsql';

create or replace trigger check_player_flag
    before insert or update on person
    for each row
    execute function check_player_flag_funk();

insert into person(id, name, surname, age, has_accepted, role_id) VALUES
                                            (10000, 'zqghslwfn', 'bzlasoalz', 28, null, 1);

select * from person where id = 10000;

delete from person where id = 10000;