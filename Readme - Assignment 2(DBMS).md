# Readme - Assignment 2(DBMS)

### RATIONALE BEHIND THE PROCESS

1) First created ER Diagrams, carefully identifying different entities, strong and weak entities and relations, cardinalities of the relationships, primary keys, attributes and their types.

2) Now using the ER Diagram, identified different tables and primary and foreign constraints.

3) Normalized the required entities. For example, created address_info table separately to satisfy 2-NF. Also, for Phone numbers, multiple values are incorporated keeping the 1 NF property of the relation.

4) Identifying the child and parent tables was a crucial step to write the foreign key constraints.

## What level of Normalization has been used?

I have normalized tables upto 3 NF. 

## Phone numbers as integers or strings?

I have used phone numbers as integers with length constraint of 11, but I l got this warning from MySQL:
`Warning: #1681 Integer display width is deprecated and will be removed in a future release.`

I searched it on StackOverflow and got the answer which looks satisfiable —> 

“The warning applies to all `INT` types: `INT`, `SMALLINT`, `TINYINT`, `MEDIUMINT`, `BIGINT`. It means in future MySQL releases there will be no need to specify display length.”

Now, I looked for phone numbers should be stored as strings  because —>

1) Different countries have different country codes that may not be integers or begin with ‘00’ or ‘+’ which will get lost if used integers

2) Phone numbers should be considered as addresses and not pure numbers, they are sequence of characters

3) Also, in MySQL -> INT(10) does not mean a 10-digit number, it means an integer with a display width of 10 digits. The maximum value for an INT in MySQL is 2147483647. 

> I had used integers as phone number’s data type earlier, and I had realised this concept of using it as string later, so I used varchar later on and altered the data types using alter table command.
> 

NOTE _ Due to time constraint, couldn’t input data into the Bus booking system, will definitely do it later!