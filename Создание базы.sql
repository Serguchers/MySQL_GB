drop database if exists gb_mysql_project;
create database gb_mysql_project;
use gb_mysql_project;


drop table if exists users;
create table users (
	id serial primary key,
	firstname varchar(50),
	lastname varchar(50),
	email varchar(120) unique,
	password_hash varchar(150),
	phone_number bigint unsigned unique,
	
	index users_names(firstname, lastname)
) COMMENT 'Пользователи';

drop table if exists chair;
create table chair (
	id int unsigned not null primary key auto_increment,
    name varchar(100)
) COMMENT 'Кафедры';

drop table if exists education_level;
create table education_level (
	id int unsigned not null primary key auto_increment,
    name enum('bachelor', 'magistracy', 'postgraduate studies', 'specialist') unique
) COMMENT 'Уровни образования';

drop table if exists speciality;
create table speciality (
	id serial primary key,
    name varchar(100),
    chair_id int unsigned not null,
    education_level_id int unsigned not null,
    
    foreign key (chair_id) references chair(id) ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key (education_level_id) references education_level(id) ON DELETE CASCADE ON UPDATE CASCADE,
    
    index chair_ind(chair_id),
    index educat_ind(education_level_id)
) COMMENT 'Специальности';

drop table if exists `group`;
create table `group` (
	id serial primary key,
    name varchar(10),
    speciality_id bigint unsigned not null,
    created_at datetime default now(),
    
    foreign key (speciality_id) references speciality(id) ON DELETE CASCADE ON UPDATE CASCADE,
    index spec_ind(speciality_id)
) COMMENT 'Группы';

drop table if exists profiles;
create table profiles (
	id bigint unsigned not null unique,
    gender enum('M', 'F'),
    birthday date,
    created_at datetime default now(),
    nationality enum('local', 'non-local', 'non-resident'),
    `status` enum('student', 'teacher'),
    photo_path varchar(255),
    
    foreign key (id) references users(id)
    on update cascade
    on delete cascade,
    
    index usr_idx(id)
    
) COMMENT 'Профили';

drop table if exists studies;
create table studies (
	id serial primary key,
    name varchar(100),
    created_at datetime default now(),
    updated_at datetime default now()
) COMMENT 'Дисциплины';

drop table if exists spec_stud;
create table spec_stud (
	id serial primary key,
	spec_id bigint unsigned not null,
    stud_id bigint unsigned not null,
    
    foreign key (spec_id) references speciality(id) ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key (stud_id) references studies(id) ON DELETE CASCADE ON UPDATE CASCADE,
    
    index spec_stud_inx(spec_id, stud_id)
) COMMENT 'Связь специальностей и дисциплин';

drop table if exists stud_teachers;
create table stud_teachers (
	id serial primary key,
    stud_id bigint unsigned not null,
    teacher_id bigint unsigned not null,
    
    foreign key (stud_id) references studies(id) ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key (teacher_id) references profiles(id) ON DELETE CASCADE ON UPDATE CASCADE,
    
    index stud_teachers_idx(stud_id, teacher_id)
) COMMENT 'Связь дисциплин и преподавателей';

drop table if exists task_type;
create table task_type (
	id int unsigned not null auto_increment unique,
    type enum('test', 'homework', 'handouts', 'poll') unique
) COMMENT 'Тип задания';

drop table if exists courses;
create table courses (
	id serial primary key,
	name varchar(120),
	creator_id bigint unsigned not null,
	study_id bigint unsigned not null,
	created_at datetime default now(),
	updated_at datetime on update now(),
	
	foreign key (creator_id) references profiles(id) ON DELETE CASCADE ON UPDATE CASCADE,
	foreign key (study_id) references studies(id) ON DELETE CASCADE ON UPDATE CASCADE,
	
	index crtr_idx(creator_id),
	index std_idx(study_id)
) COMMENT 'Курсы';

drop table if exists tasks;
create table tasks (
	id serial primary key,
    name varchar(50),
    group_id bigint unsigned not null,
    created_at datetime default now(),
    updated_at datetime on update now(),
    type_id int unsigned not null,
    course_id bigint unsigned not null,
    
    foreign key (type_id) references task_type(id) ON DELETE CASCADE ON UPDATE CASCADE,
	foreign key (group_id) references `group`(id) ON DELETE CASCADE ON UPDATE CASCADE,
	foreign key (course_id) references courses(id) ON DELETE CASCADE ON UPDATE CASCADE,
    
    index group_idx(group_id)
) COMMENT 'Задания';

drop table if exists attached_files;
create table attached_files (
	id serial primary key,
    creator_id bigint unsigned not null,
    task_id bigint unsigned not null,
    created_at datetime default now(),
    filepath varchar(255),
    
    foreign key (creator_id) references profiles(id) ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key (task_id) references tasks(id) ON DELETE CASCADE ON UPDATE CASCADE,
    
    index creator_idx(creator_id),
    index task_idx(task_id)
) COMMENT 'Прикрепленные файлы';

drop table if exists marks;
create table marks (
	user_id bigint unsigned not null,
    value enum('1', '2', '3', '4', '5'),
    task_id bigint unsigned not null,
    `comment` text,
    created_at datetime default now(),
    updated_at datetime on update now(),
    
    foreign key (user_id) references profiles(id) ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key (task_id) references tasks(id) ON DELETE CASCADE ON UPDATE CASCADE,
    
    index usr_idx(user_id),
    index task_idx(task_id)
) COMMENT 'Оценки';

drop table if exists messages;
create table messages (
	id serial primary key,
	from_user_id bigint unsigned not null,
    to_user_id bigint unsigned not null,
    body text,
    created_at datetime default now(),
    
    foreign key (from_user_id) references users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key (to_user_id) references users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    
    index usr_msgs_idx(from_user_id, to_user_id)
) COMMENT 'Сообщения';