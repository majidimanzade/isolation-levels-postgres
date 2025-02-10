
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
Repeatable Read is an isolation level in databases that ensures once a transaction reads a value, it will see the same value throughout the rest of the transaction, even if other transactions modify the data. This isolation level prevents non-repeatable reads but still allows phantom reads.

```sql
-- In Session 1
BEGIN;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT * FROM accounts;
SELECT pg_sleep(10);
-- In Session 1 (after update in Session 2)
SELECT * FROM accounts;
COMMIT; 

-- In Session 2
UPDATE accounts SET balance = 23;
```
if you run this without setting isolation level its going to give you updated values.

### Example with Phantom Reads:
```sql
-- In Session 1
BEGIN;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT * FROM accounts;
SELECT pg_sleep(10);
-- In Session 1 (after update in Session 2)
SELECT * FROM accounts;
COMMIT; 

-- In Session 2
INSERT INTO accounts (balance) VALUES (60);
```
Under the Repeatable Read isolation level in PostgreSQL (and many other databases), a transaction sees the consistent snapshot of the data from the moment the transaction begins. This means that any new rows that are inserted or deleted by other transactions will not be visible to the current transaction.

So, if a new row is added to the database (which would meet the criteria of your query) during your transaction, it will not appear when you re-query the database, because your transaction is operating on a snapshot of the data as it was at the time the transaction started.

## Serializable
The Serializable isolation level is the highest level of isolation in relational databases. It provides the strongest guarantee for transaction isolation by ensuring that transactions behave as if they were executed serially, one after the other, without overlapping.

In Serializable isolation, the database guarantees that the results of running multiple transactions concurrently will be the same as if they had been executed one at a time (serially), without any overlap
