# Database_labs
Разработка, создание и заполнение базы данных, а также создание скриптов для обеспечения целостности данных.

# Лабораторная работа #1
Для выполнения лабораторной работы №1 необходимо выбрать предметную область, на основании которой в следующих лабораторных работах (3,4,5) будет создаваться база данных. Предметная область должна быть согласована с преподавателем.

После согласования необходимо составить подробное текстовое описание предметной области.

Отчёт по лабораторной работе должен содержать:

титульный лист;
текст задания;
описание предметной области;
Темы для подготовки к защите лабораторной работы:

Многоуровневая архитектура информационных систем.
Зачем нужны базы данных?
СУБД.
Этапы построения базы данных.
Язык SQL


# Лабораторная работа #2
Для выполнения лабораторной работы №2 необходимо:

На основе предложенной предметной области (текста) составить ее описание. Из полученного описания выделить сущности, их атрибуты и связи.
Составить инфологическую модель.
Составить даталогическую модель. При описании типов данных для атрибутов должны использоваться типы из СУБД PostgreSQL.
Реализовать даталогическую модель в PostgreSQL. При описании и реализации даталогической модели должны учитываться ограничения целостности, которые характерны для полученной предметной области.
Заполнить созданные таблицы тестовыми данными.
Для создания объектов базы данных у каждого студента есть своя схема. Название схемы соответствует имени пользователя в базе studs (sXXXXXX). Команда для подключения к базе studs:

psql -h pg -d studs

Каждый студент должен использовать свою схему при работе над лабораторной работой №2 (а также в рамках выполнения лабораторных работ 3, 4, 5).

Отчёт по лабораторной работе должен содержать:

титульный лист;
текст задания;
описание предметной области;
список сущностей и их классификацию (стержневая, ассоциация, характеристика);
инфологическая модель (ER-диаграмма в расширенном виде - с атрибутами, ключами...);
даталогическая модель (должна содержать типы атрибутов, вспомогательные таблицы для отображения связей "многие-ко-многим");
реализация даталогической модели на SQL;
выводы по работе;

Темы для подготовки к защите лабораторной работы:

Инфологическая модель.
Даталогическая модель.
Классификация сущностей.
Виды связей.
Ограничения целостности.
DDL.
DML.


# Лабораторная работа #3
Для выполнения лабораторной работы №3 необходимо:

Сформировать ER-модель и нарисовать ER-диаграмму предметной области, которая была описана в рамках лабораторной работы №1. ER-модель должна соответствовать описанию, представленному в лабораторной работе №1.
На основе ER-модели построить даталогическую модель.
Отчёт по лабораторной работе должен содержать:

титульный лист;
текст задания;
описание предметной области;
инфологическая модель;
даталогическая модель;
выводы по работе;
Темы для подготовки к защите лабораторной работы:

Инфологическая модель.
Построение ER-диаграммы.
Классификация сущностей.
Даталогическая модель.


# Лабораторная работа #4
Для выполнения лабораторной работы №4 необходимо:

Реализовать разработанную в рамках лабораторной работы №3 даталогическую модель в реляционной СУБД PostgreSQL.
Заполнить созданные таблицы данными.
Обеспечить целостность данных при помощи средств языка DDL.
В рамках лабораторной работы должны быть разработаны скрипты для создания/удаления требуемых объектов базы данных, заполнения/удаления содержимого созданных таблиц.
Отчёт по лабораторной работе должен содержать:

титульный лист;
текст задания;
описание предметной области;
DDL-скрипты, часть DML-скриптов;
выводы по работе;
Темы для подготовки к защите лабораторной работы:

Язык DDL
Обеспечение целостности данных
Язык DML


# Лабораторная работа #5
Для выполнения лабораторной работы №5 необходимо:

Добавить в ранее созданную базу данных (лр №4) триггеры для обеспечения комплексных ограничений целостности.
Реализовать функции и процедуры на основе описания бизнес-процессов, определенных при описании предметной области (лр №1). Должна быть обеспечена проверка корректности вводимых данных для созданных функций и процедур.
Необходимо произвести анализ использования созданной базы данных, выявить наиболее часто используемые объекты базы данных, виды запросов к ним. Результаты должны быть представлены в виде текстового описания.
На основании полученного описания требуется создать подходящие индексы и доказать, что они будут полезны для представленных в описании случаев использования базы данных.
Отчёт по лабораторной работе должен содержать:

титульный лист;
текст задания;
код триггеров, функций, процедур;
описание наиболее часто используемых сценариев при работе с базой данных;
описание индексов и обоснование их использования;
выводы по работе;
Темы для подготовки к защите лабораторной работы:

PL/pgSQL
процедуры, функции
триггеры
индексы
