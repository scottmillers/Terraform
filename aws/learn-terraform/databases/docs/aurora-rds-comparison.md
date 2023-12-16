# Aurora and RDS Comparison


|| Aurora | RDS    |
|---------------------------|------------------------------------------------------|--------|
| Features | MySQL and PostgresSQL compatible | MySQL, PostgresSQL, MariaDB, Oracle, SQL Server       |
| Maximum storage capacity  | 128 TB | 64 TB for MySQL, MariaDB, Oracle, and PostgreSQL engines & 16 TB for SQL Server engine  |



## References

https://tutorialsdojo.com/amazon-aurora-vs-amazon-rds/


## Question Exam 5 - Question 16

A company has recently adopted a hybrid cloud architecture and is planning to migrate a database hosted on-premises to AWS. The database currently has over 50 TB of consumer data, handles highly transactional (OLTP) workloads, and is expected to grow. The Solutions Architect should ensure that the database is ACID-compliant and can handle complex queries of the application.

Which type of database service should the Architect use?

Answer: Aurora
Amazon RDS is incorrect. Although this service can host an ACID-compliant relational database that can handle complex queries and transactional (OLTP) workloads, it is still not scalable to handle the growth of the database. Amazon Aurora is the better choice as its underlying storage can grow automatically as needed.

