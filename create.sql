/* create */
create table role(
    id integer primary key,
    name varchar(30) not null unique check ( name in ('Player', 'Organizator', 'Arbitr', 'Staff')),
    description text not null
);

create table tournament(
    id integer primary key,
    name varchar(200) not null,
    description text not null,
    start_date date not null
);

create table person(
    id integer primary key,
    name varchar(30) not null,
    surname varchar(30) not null,
    age integer not null,
    has_accepted boolean,
    role_id integer not null,
    foreign key (role_id) references role(id) on delete cascade
);

create table invite(
    id integer primary key,
    competition_info text not null,
    send_date date not null,
    date_to_response date not null,
    org_id integer not null,
    player_id integer not null,
    tournament_id integer not null,
    foreign key (org_id) references person(id) on delete cascade,
    foreign key (player_id) references person(id) on delete cascade,
    foreign key (tournament_id) references tournament(id) on delete cascade
);

create table response(
    id integer primary key,
    answer text not null,
    send_date date not null,
    org_id integer not null,
    player_id integer not null,
    tournament_id integer not null,
    foreign key (org_id) references person(id) on delete cascade,
    foreign key (player_id) references person(id) on delete cascade,
    foreign key (tournament_id) references tournament(id) on delete cascade
);

create table entrance_fee(
    id integer primary key,
    money integer not null check (money=300),
    org_id integer not null,
    player_id integer not null,
    tournament_id integer not null,
    foreign key (org_id) references person(id) on delete cascade,
    foreign key (player_id) references person(id) on delete cascade,
    foreign key (tournament_id) references tournament(id) on delete cascade
);

create table draw(
    id integer primary key,
    draw_number integer not null check ( draw_number>=1 and draw_number<=8 ),
    player_id integer not null,
    arb_id integer not null,
    tournament_id integer not null,
    foreign key (arb_id) references person(id) on delete cascade,
    foreign key (player_id) references person(id) on delete cascade,
    foreign key (tournament_id) references tournament(id) on delete cascade
);

create table score(
    id integer primary key,
    score decimal not null default 0,
    player_id integer not null,
    tournament_id integer not null,
    foreign key (player_id) references person(id) on delete cascade,
    foreign key (tournament_id) references tournament(id) on delete cascade
);

create table inventory(
    id integer primary key,
    name varchar(30) not null,
    description text not null,
    staff_id integer not null,
    foreign key (staff_id) references person(id) on delete cascade
);

create table game(
    id integer primary key,
    player1_id integer not null,
    player2_id integer not null,
    arb_id integer not null,
    tournament_id integer not null,
    result integer not null check ( result>=0 and result<=2 ),
    tour integer not null,
    start_date date not null,
    foreign key (arb_id) references person(id) on delete cascade,
    foreign key (player1_id) references person(id) on delete cascade,
    foreign key (player2_id) references person(id) on delete cascade,
    foreign key (tournament_id) references tournament(id) on delete cascade
);

create table tournament_person(
    tournament_id integer references tournament on delete cascade,
    person_id integer references person on delete cascade,
    primary key (tournament_id, person_id)
);

create table game_staff(
    game_id integer references game on delete cascade,
    staff_id integer references person on delete cascade,
    primary key (game_id, staff_id)
);

create table game_inventory(
    game_id integer references game on delete cascade,
    inventory_id integer references inventory on delete cascade,
    primary key (game_id, inventory_id)
);

create table tournament_inventory(
    tournament_id integer references tournament on delete cascade,
    inventory_id integer references inventory on delete cascade,
    primary key (tournament_id, inventory_id)
);