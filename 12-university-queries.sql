﻿CREATE TABLE Группа_студентов
(
Номер_группы integer NOT NULL
)
go

CREATE TABLE Преподаватель
(
Номер_табеля integer NOT NULL ,
ФИО_преподавателя varchar(80) NULL
)
go

CREATE TABLE Аудитория
(
Номер_аудитории integer NOT NULL ,
Номер_корпуса integer NOT NULL
)
go

CREATE TABLE Дисциплина
(
Код_дисциплины integer NOT NULL ,
Название_дисциплины varchar(20) NULL
)
go

CREATE TABLE Занятие
(
Время time NOT NULL ,
День_недели integer NOT NULL ,
Номер_табеля integer NOT NULL ,
Код_дисциплины integer NOT NULL ,
Номер_аудитории integer NOT NULL ,
Номер_корпуса integer NOT NULL ,
Номер_группы integer NOT NULL
)
go

ALTER TABLE Аудитория
ADD CONSTRAINT XPKАудитория PRIMARY KEY CLUSTERED (Номер_аудитории ASC,Номер_корпуса ASC)
go

ALTER TABLE Группа_студентов
ADD CONSTRAINT XPKГруппа_студентов PRIMARY KEY CLUSTERED (Номер_группы ASC)
go

ALTER TABLE Дисциплина
ADD CONSTRAINT XPKДисциплина PRIMARY KEY CLUSTERED (Код_дисциплины ASC)
go

ALTER TABLE Занятие
ADD CONSTRAINT XPKЗанятие PRIMARY KEY CLUSTERED (Время ASC,День_недели ASC,Номер_группы ASC)
go

ALTER TABLE Преподаватель
ADD CONSTRAINT XPKПреподаватель PRIMARY KEY CLUSTERED (Номер_табеля ASC)
go

ALTER TABLE Занятие
ADD CONSTRAINT R_2 FOREIGN KEY (Номер_табеля) REFERENCES Преподаватель(Номер_табеля)
ON DELETE NO ACTION
ON UPDATE NO ACTION
go

ALTER TABLE Занятие
ADD CONSTRAINT R_3 FOREIGN KEY (Код_дисциплины) REFERENCES Дисциплина(Код_дисциплины)
ON DELETE NO ACTION
ON UPDATE NO ACTION
go

ALTER TABLE Занятие
ADD CONSTRAINT R_4 FOREIGN KEY (Номер_аудитории,Номер_корпуса) REFERENCES Аудитория(Номер_аудитории,Номер_корпуса)
ON DELETE NO ACTION
ON UPDATE NO ACTION
go

ALTER TABLE Занятие
ADD CONSTRAINT R_5 FOREIGN KEY (Номер_группы) REFERENCES Группа_студентов(Номер_группы)
ON DELETE NO ACTION
ON UPDATE NO ACTION
go

INSERT INTO Группа_студентов VALUES 
(11),
(21),
(30),
(41),
(51),
(61),
(71),
(81),
(6101),
(6102),
(6103),
(6104),
(6105),
(6106),
(6107),
(6108);
go

INSERT INTO Преподаватель VALUES
(18923, 'Ватутин И.Н.'),
(21545, 'Щукин В.Ж.'),
(21892, 'Ваваева В.А.'),
(38293, 'Лцулодова М.М.'),
(56534, 'Вфыл А.М.'),
(101001, 'Сдавельчин М.А.'),
(212211, 'Лазурина В.Ю.'),
(909090, 'Лущовых Б.Б.'),
(910323, 'Взуващев С.М.'),
(9120121, 'Вывамин А.А.');
go

INSERT INTO Аудитория VALUES
(101, 1),
(102, 3),
(102, 9),
(201, 4),
(202, 4),
(204, 4),
(411, 5),
(411, 9),
(412, 5),
(412, 9),
(413, 5),
(413, 9),
(414, 5),
(414, 9),
(415, 5)
go

INSERT INTO Дисциплина VALUES
(1002, 'Математика'),
(1003, 'Физика'),
(1004, 'Программирование'),
(1076, 'Базы данных'),
(1232, 'Моделирование'),
(1303, 'Графика'),
(2001, 'Численные методы'),
(3308, 'Правоведение');
go

INSERT INTO Занятие VALUES
('00:00', 6, 21545, 1002, 414, 5, 6103),
('07:00', 1, 9120121, 1003, 202, 4, 51),
('09:00', 1, 56534, 1004, 202, 4, 51),
('09:00', 1, 909090, 1003, 412, 9, 6101),
('09:00', 2, 909090, 1003, 412, 9, 6101),
('09:00', 3, 21892, 2001, 411, 5, 6101),
('09:00', 4, 21892, 2001, 411, 5, 6101),
('09:00', 5, 21892, 2001, 411, 5, 6101),
('09:45', 2, 18923, 1002, 101, 1, 11),
('11:00', 5, 21892, 2001, 101, 1, 6101),
('11:30', 1, 212211, 1002, 412, 5, 21),
('11:30', 3, 101001, 1232, 412, 5, 30),
('11:30', 3, 18923, 1232, 102, 9, 6105),
('12:00', 4, 101001, 1004, 102, 9, 6105),
('13:00', 2, 101001, 1004, 102, 9, 6106),
('13:30', 3, 21545, 1002, 413, 5, 6102),
('13:30', 5, 9120121, 1002, 102, 3, 61),
('13:30', 6, 101001, 1003, 102, 9, 61),
('15:15', 4, 21892, 1076, 414, 9, 6101),
('16:50', 4, 21892, 1076, 414, 9, 6101);
go

SELECT * FROM Группа_студентов;
SELECT * FROM Преподаватель;
SELECT * FROM Аудитория;
SELECT * FROM Дисциплина;
SELECT * FROM Занятие;

-- выбрать все занятия с указанием аудитории по группам
-- в запросе использованы конструкции AS, ORDER BY и внутреннее соединение
SELECT Время,
День_недели AS 'День недели',
Номер_аудитории AS Àудитория,
Номер_корпуса AS Корпус,
Номер_группы AS Группа
FROM Занятие
ORDER BY Номер_группы;

-- подсчитать количество часов занятий в неделю по группам
-- в запросе использована конструкция GROUP BY и агрегатная функция COUNT
SELECT Номер_группы,
COUNT(*)*2 AS 'Число занятий'
FROM Занятие
GROUP BY Номер_группы
ORDER BY Номер_группы;

-- выбрать все занятия с указанием аудиторий по определенному преподавателю
-- в запросе использована конструкция WHERE и предикат LIKE
SELECT
ФИО_преподавателя AS 'ФИО преподавателя',
День_недели AS 'День недели',
Время,
Дисциплина.Название_дисциплины AS Дисциплина,
Номер_аудитории AS Àудитория,
Номер_корпуса AS Корпус,
Номер_группы AS Группа
FROM Занятие
JOIN Преподаватель ON Преподаватель.Номер_табеля = Занятие.Номер_табеля
JOIN Дисциплина ON Занятие.Код_дисциплины = Дисциплина.Код_дисциплины
WHERE ФИО_преподавателя LIKE 'Сд%';

-- подсчитать количество часов занятий по определенному преподавателю
-- в запросе использована конструкция HAVING
SELECT
ФИО_преподавателя AS 'ФИО преподавателя',
COUNT(*)*2 AS 'Число часов'
FROM Занятие
JOIN Преподаватель ON Преподаватель.Номер_табеля = Занятие.Номер_табеля
GROUP BY ФИО_преподавателя
HAVING ФИО_преподавателя LIKE 'Сд%'
ORDER BY ФИО_преподавателя;

-- выбрать все дисциплины, которые не указаны в расписании
-- в решении использовано предложение DISTINCT и оператор EXCEPT
SELECT Название_дисциплины FROM Дисциплина EXCEPT
SELECT DISTINCT Название_дисциплины
FROM Занятие
JOIN Дисциплина ON Занятие.Код_дисциплины = Дисциплина.Код_дисциплины

-- решение той же задачи с использованием правого внешнего соединения и предиката IS NULL
SELECT Название_дисциплины
FROM Занятие RIGHT OUTER JOIN Дисциплина ON Занятие.Код_дисциплины = Дисциплина.Код_дисциплины
WHERE Время IS NULL

-- выбрать всех преподавателей, которые не указаны в расписании
SELECT ФИО_преподавателя FROM Преподаватель EXCEPT
SELECT DISTINCT ФИО_преподавателя
FROM Занятие
JOIN Преподаватель ON Занятие.Номер_табеля = Преподаватель.Номер_табеля

-- подсчитать общее количество часов занятий в неделю по аудиториям или определенной аудитории
-- здесь использована множественная группировка и сортировка
SELECT
Номер_аудитории,
Номер_корпуса,
COUNT(*)*2 AS 'Число часов'
FROM Занятие
GROUP BY Номер_аудитории, Номер_корпуса
ORDER BY Номер_корпуса, Номер_аудитории;

-- пример для предиката BETWEEN: выбрать занятия во вторую смену
SELECT Время,
День_недели,
Номер_группы,
Название_дисциплины,
ФИО_преподавателя,
Номер_аудитории,
Номер_корпуса
FROM Занятие
JOIN Преподаватель ON Преподаватель.Номер_табеля = Занятие.Номер_табеля
JOIN Дисциплина ON Занятие.Код_дисциплины = Дисциплина.Код_дисциплины
WHERE Время BETWEEN '13:00' AND '19:00';

-- пример для сортировки по нескольким столбцам: показать расписание для заданной группы.
SELECT
День_недели AS 'День недели',
Время,
Название_дисциплины AS Дисциплина,
ФИО_преподавателя,
Номер_аудитории,
Номер_корпуса
FROM Занятие
JOIN Преподаватель ON Преподаватель.Номер_табеля = Занятие.Номер_табеля
JOIN Дисциплина ON Занятие.Код_дисциплины = Дисциплина.Код_дисциплины
WHERE Номер_группы = 6101
ORDER BY День_недели, Время;

-- пример для предиката IN: показать расписание для нескольких групп
SELECT
Номер_группы,
День_недели AS 'День недели',
Время,
Название_дисциплины AS Дисциплина,
ФИО_преподавателя,
Номер_аудитории,
Номер_корпуса
FROM Занятие
JOIN Преподаватель ON Преподаватель.Номер_табеля = Занятие.Номер_табеля
JOIN Дисциплина ON Занятие.Код_дисциплины = Дисциплина.Код_дисциплины
WHERE Номер_группы IN (61, 6101)
ORDER BY Номер_группы, День_недели, Время;

-- запрос, решающий ту же задачу с использованием оператора UNION
SELECT
Номер_группы,
День_недели AS 'День недели',
Время,
Название_дисциплины AS Дисциплина
FROM Занятие
JOIN Дисциплина ON Занятие.Код_дисциплины = Дисциплина.Код_дисциплины
WHERE Номер_группы = 61
UNION
SELECT
Номер_группы,
День_недели AS 'День недели',
Время,
Название_дисциплины AS Дисциплина
FROM Занятие
JOIN Дисциплина ON Занятие.Код_дисциплины = Дисциплина.Код_дисциплины
WHERE Номер_группы = 6101
ORDER BY Номер_группы, День_недели, Время;

-- примеры запросов INSERT, UPDATE, DELETE
INSERT INTO Дисциплина VALUES (1303, 'Графика');
INSERT INTO Дисциплина VALUES (3308, 'Правоведение');
UPDATE Дисциплина SET Название_дисциплины = 'Неизвестная дисциплина' WHERE Код_дисциплины BETWEEN 1100 AND 1200;
DELETE FROM Дисциплина WHERE Название_дисциплины = 'Неизвестная дисциплина';