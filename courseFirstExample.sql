begin;
create table if not exists user_profile(
    id bigserial primary key,
    first_name TEXT not null,
    last_name TEXT not null,
    email TEXT unique not null,
    gender text check(gender in ('Male','Female')) not null,
    created_at timestamp without time zone not null
);


create table if not exists youtube_account(
    id  bigint PRIMARY key REFERENCES user_profile(id),
    created_at timestamp without time zone not null
);

create table if not exists youtube_channel(
    id bigserial PRIMARY key,
    youtube_account_id bigint not null REFERENCES youtube_account(id),
    channel_name TEXT NOT NULL UNIQUE,
    created_at timestamp without time zone not null
);

create table if not exists channel_subscriber(
    youtube_account_id BIGINT REFERENCES youtube_account(id),
    youtube_channel_id BIGINT REFERENCES youtube_channel(id),
    created_at timestamp without time zone not null,
    primary key (youtube_account_id, youtube_channel_id)
);


-- users
insert into user_profile (id, first_name, last_name, email, gender, created_at) 
values (1, 'Marj', 'Possa', 'mpossa0@sciencedaily.com', 'Female', '2022-04-15 22:00:44');

insert into user_profile (id, first_name, last_name, email, gender, created_at) 
values (2, 'Sergio', 'Geroldini', 'sgeroldini1@tinypic.com', 'Male', '2021-08-21 21:36:00');

insert into user_profile (id, first_name, last_name, email, gender, created_at) 
values (3, 'Tailor', 'Copestick', 'tcopestick2@youku.com', 'Male', '2022-03-14 19:35:50');

insert into user_profile (id, first_name, last_name, email, gender, created_at) 
values (4, 'Holt', 'Dayton', 'hdayton3@cmu.edu', 'Male', '2022-01-20 22:25:25');



-- accounts
insert into youtube_account(id, created_at)
values (1,'2022-04-15 02:59:00');

insert into youtube_account(id, created_at)
values (2,'2022-04-15 11:59:00');

insert into youtube_account(id, created_at)
values (3,'2022-04-15 17:59:00');

insert into youtube_account(id, created_at)
values (4,'2022-04-15 14:59:00');

-- cheetsheet for account
insert into youtube_account(id, created_at) 
select id,now() as created_at from user_profile
where email = 'sgeroldini1@tinypic.com'


-- youtube channels
insert into youtube_channel(id, youtube_account_id, channel_name, created_at)
values (1, 1, 'MarjPossa', '2022-04-15 22:13:20');

insert into youtube_channel(id, youtube_account_id, channel_name, created_at)
values (2, 2, 'SergioGeroldini', '2022-04-15 22:59:08');

insert into youtube_channel(id, youtube_account_id, channel_name, created_at)
values (3, 4, 'TailorCopestick', '2022-04-15 22:59:07');


-- subscribers

insert into channel_subscriber(youtube_account_id, youtube_channel_id, created_at)
values (1, 2, '2022-04-15 13:56:10');

insert into channel_subscriber(youtube_account_id, youtube_channel_id, created_at)
values (1, 3, '2022-04-15 01:9:09');

insert into channel_subscriber(youtube_account_id, youtube_channel_id, created_at)
values (4, 1, '2022-04-15 13:34:30');

insert into channel_subscriber(youtube_account_id, youtube_channel_id, created_at)
values (2, 1, '2022-04-15 02:59:10');

commit;


select * from user_profile
join youtube_account ya on user_profile.id = ya.id
join channel_subscriber on ya.id = channel_subscriber.youtube_account_id
join youtube_channel yc on channel_subscriber.youtube_channel_id = yc.id


select * from user_profile
left join youtube_account ya on user_profile.id = ya.id
left join channel_subscriber on ya.id = channel_subscriber.youtube_account_id
left join youtube_channel yc on channel_subscriber.youtube_channel_id = yc.id