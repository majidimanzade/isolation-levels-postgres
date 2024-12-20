# Isolation Level Simulation

## Read Committed
### Environment setup

1. clone the project
2. give access and run shell script
```console
chmod +x setup_postgres.sh
./setup_postgres.sh
```
3. open two session(terminal)

in the first terminal run this command
```sql
begin; update accounts set balance = balance - 50; select pg_sleep(10); end;
```

in the second terminal run this command and check if data has changed or not
```sql
select * from accounts
```

Our first Transaction takes 10 seconds to be completed. first command of our sql is updating accounts
and after that sleep for 10 seconds.
if you try to see data in 10 seconds, you will just see the committed data and uncommitted data is not accessable yet.


## Repeatable Read



# Isolation Level Simulation 
## Read Committed 
### Environment Setup 
1. Clone the project. 
2. Grant access and run the shell script: 
```bash 
chmod +x setup_postgres.sh ./setup_postgres.sh
``` 

3. Open two terminal sessions. 
In the first terminal, run this command: 
```sql 
BEGIN; UPDATE accounts SET balance = balance - 50; SELECT pg_sleep(10); END; 
```
In the second terminal, run the following command to check if the data has changed: 
```sql 
SELECT * FROM accounts; 
``` 
The first transaction will take 10 seconds to complete. 
The initial SQL command updates the accounts table, then pauses for 10 seconds. 
If you try to view the data within those 10 seconds, you will only see the committed data. Uncommitted data will not be accessible until the transaction is completed.
## Repeatable Read
