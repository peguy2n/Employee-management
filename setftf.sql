#Select the last name of all employees.
SELECT LastName FROM Employees;

#Select the last name of all employees, without duplicates. 
SELECT DISTINCT LastName FROM Employees;

#Select all the data of employees whose last name is "Smith". 
SELECT * FROM Employees WHERE LastName = 'Smith';

#Select all the data of employees whose last name is "Smith" or "Doe".
/* With OR */ SELECT * FROM Employees WHERE LastName = 'Smith' OR LastName = 'Doe';

/* With IN */ SELECT * FROM Employees WHERE LastName IN ('Smith' , 'Doe');

#Select all the data of employees that work in department 14. 
SELECT * FROM Employees WHERE Department = 14;

#Select all the data of employees that work in department 37 or department 77. 
/* With OR */ SELECT * FROM Employees WHERE Department = 37 OR Department = 77;

/* With IN */ SELECT * FROM Employees WHERE Department IN (37,77);

#Select all the data of employees whose last name begins with an "S". 
SELECT * FROM Employees WHERE LastName LIKE 'S%';

#Select the sum of all the departments' budgets. 
SELECT SUM(Budget) FROM Departments;

#Select the number of employees in each department (you only need to show the department code and the number of employees). 
SELECT Department, COUNT(*) FROM Employees GROUP BY Department;

#Select all the data of employees, including each employee's department's data. 
SELECT * FROM Employees E INNER JOIN Departments D ON E.Department = D.Code;

#Select the name and last name of each employee, along with the name and budget of the employee's department. 
/* Without labels */ SELECT Employees.Name, LastName, Departments.Name AS DepartmentsName, Budget FROM Employees INNER JOIN Departments ON Employees.Department = Departments.Code;

/* With labels */ SELECT E.Name, LastName, D.Name AS DepartmentsName, Budget FROM Employees E INNER JOIN Departments D ON E.Department = D.Code;

#Select the name and last name of employees working for departments with a budget greater than $60,000.
/* Without subquery */ SELECT Employees.Name, LastName FROM Employees INNER JOIN Departments ON Employees.Department = Departments.Code AND Departments.Budget > 60000;
/* With subquery */ SELECT Name, LastName FROM Employees WHERE Department IN (SELECT Code FROM Departments WHERE Budget > 60000);

#Select the departments with a budget larger than the average budget of all the departments.
SELECT * FROM Departments WHERE Budget > ( SELECT AVG(Budget) FROM Departments );

#Select the names of departments with more than two employees.
/With subquery/ SELECT D.Name FROM Departments D WHERE 2 < ( SELECT COUNT(*) FROM Employees WHERE Department = D.Code );
/* With IN and subquery / SELECT Name FROM Departments WHERE Code IN ( SELECT Department FROM Employees GROUP BY Department HAVING COUNT() > 2 );
/* With UNION. This assumes that no two departments have the same name / SELECT Departments.Name FROM Employees INNER JOIN Departments ON Department = Code GROUP BY Departments.Name HAVING COUNT() > 2;

#Select the name and last name of employees working for departments with second lowest budget. 
/* With subquery */ SELECT e.Name, e.LastName FROM Employees e WHERE e.Department = ( SELECT sub.Code FROM (SELECT * FROM Departments d ORDER BY d.budget LIMIT 2) sub ORDER BY budget DESC LIMIT 1);
/* With subquery */ SELECT Name, LastName FROM Employees WHERE Department IN ( SELECT Code FROM Departments WHERE Budget = ( SELECT TOP 1 Budget FROM Departments WHERE Budget IN ( SELECT DISTINCT TOP 2 Budget FROM Departments ORDER BY Budget ASC ) ORDER BY Budget DESC ) );

#Add a new department called "Quality Assurance", with a budget of $40,000 and departmental code 11. Add an employee called "Mary Moore" in that department, with SSN 847-21-9811. INSERT INTO Departments VALUES ( 11 , 'Quality Assurance' , 40000);
INSERT INTO Employees VALUES ( '847219811' , 'Mary' , 'Moore' , 11);

#Reduce the budget of all departments by 10%. 
UPDATE Departments SET Budget = Budget * 0.9;

#Reassign all employees from the Research department (code 77) to the IT department (code 14). 
UPDATE Employees SET Department = 14 WHERE Department = 77;

#Delete from the table all employees in the IT department (code 14). 
DELETE FROM Employees WHERE Department = 14;

#Delete from the table all employees who work in departments with a budget greater than or equal to $60,000.
DELETE FROM Employees WHERE Department IN ( SELECT Code FROM Departments WHERE Budget >= 60000 );

#Delete from the table all employees. 
DELETE FROM Employees;
