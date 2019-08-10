create table Staff(--����Ա����
Job_number VARCHAR(50) NOT NULL primary key,
Name VARCHAR(50) NOT NULL,
Gender CHAR(2)CHECK(Gender IN('��','Ů')),
Age int NOT NULL,
Hometown VARCHAR(50) NOT NULL,
ID_number VARCHAR(50) UNIQUE NOT NULL,
Marital_status VARCHAR(50),
Educational VARCHAR(50),
Department VARCHAR(50) NOT NULL,
Trades VARCHAR(50),
gongling VARCHAR(50) NOT NULL,
Job_classification VARCHAR(50),
Post_wages decimal not null
)
create table Depart(--�������ű�
Job_number VARCHAR(50) NOT NULL,
Department VARCHAR(50) primary key NOT NULL,
header VARCHAR(50) NOT NULL,
Sector_workforce VARCHAR(50)
)
CREATE TABLE Wage(--�������ʱ�
Job_number varchar(50) not null primary key foreign key references Staff(Job_number),
Job_subsidies decimal,
Attendance_Days decimal not null,
Overtime_hours decimal, 
Overtime_Days decimal, 
Overtime_Category decimal,
Overtime_pay varchar(50),
Sick_leave_deductions decimal,
Leave_chargeback decimal, 
Other_deductions decimal, 
Should_wages decimal not null, 
Real_wages decimal not null
)
go
CREATE VIEW Staff_Wage--������ͼ��Ա��-����
AS 
SELECT Staff.Name ����, Wage.Job_number ����,Staff.Post_wages ��λ����,Wage.Job_subsidies ��λ����,
Wage.Attendance_Days ��������,Wage.Overtime_hours �Ӱ๤ʱ,Wage.Overtime_Days �Ӱ�����,
Wage.Overtime_Category �Ӱ����,Wage.Overtime_pay �Ӱ๤��,Wage.Sick_leave_deductions ���ٿۿ�,
Wage.Leave_chargeback �¼ٿۿ�,Wage.Other_deductions �����ۿ�,Wage.Should_wages Ӧ������,
Wage.Real_wages ʵ������
FROM  Staff,Wage
WHERE  Staff.Job_number=Wage.Job_number;
go
go
CREATE VIEW DepartStaff_renshi--������ͼ������-��Ա�����²���--����Ϊ����,������������,���Լ������������ͼ.
AS
SELECT Staff.Job_number ����,Staff.Name ����,Staff.Gender �Ա�,Staff.Age ����,Staff.Hometown ����,
Staff.ID_number ���֤��,Staff.Marital_status ����״��,Staff.Educational ѧ��,Staff.Department ��������,
Staff.Trades ����,Staff.gongling ����,Staff.Job_classification ְ��ȼ�,Staff.Post_wages ��λ����
FROM Depart,Staff
WHERE Depart.Department=Staff.Department and Staff.Department='���²�';
go
CREATE INDEX Job_number_name_ind--��������
ON staff(Job_number,Name)

--����洢������,��λ����(��staffgongzi)����������(��staffchuqin)���Ӱ๤��(��staffjiaban)��
--Ӧ������(��staffying)��ʵ������(��staffshi)Ϊ�����������ָ��Ա��������Ϣ��
go
CREATE PROCEDURE staffCost
@staffgongzi decimal,
@staffchuqin decimal,
@staffjiaban decimal,
@staffying decimal,
@staffshi decimal
AS
SELECT *
FROM Wage
WHERE Job_subsidies=@staffgongzi AND Attendance_Days=@staffchuqin AND Overtime_pay=@staffjiaban AND 
      Should_wages=@staffying AND Real_wages=@staffshi;
	  go
--����������:Ա���ڲ�����,��ϵͳ��Ա�������UPDATE�����󣬽����Զ���������
--�ô���������Ӧ��¼�Ĳ����������������ơ����ʸ��¡�
CREATE TRIGGER tri1 
ON Staff for insert
as
update Depart set Sector_workforce=Sector_workforce+1
   where Depart.Job_number in(select Job_number from inserted)
go
--�����û�u1����½��sss������123456.
CREATE LOGIN sss WITH PASSWORD='123456'
USE  gongzigl 
CREATE USER u1 FOR LOGIN sss;
--��u1��Ȩ
grant all privileges
on staff
to u1
with grant option;
CREATE LOGIN ss WITH PASSWORD='123456'
USE  gongzigl 
CREATE USER u2 FOR LOGIN ss
grant update,insert
on staff
to u2
with grant option;
CREATE LOGIN s WITH PASSWORD='123456'
USE  gongzigl 
CREATE USER u3 FOR LOGIN s
grant select
on staff
to u3
with grant option;