# Node Application

## feature
- Add
- Query

## How to use?
1. If you want to use command-line for query of add new data to ledger,
You can:
```
node app.js query Alice
```
Or:
```
node app.js add Alex 50 60 70
```
2. Moreover, we also can devlop a client application, just like: website, app...and so on.
So, we provide a rest Api in order to get more convenient when we need to fetch data from ledger.
```
node rest.js
```
- Query
```
type: post
url: localhost:8080/find
body:
{
"name":"Alice"
}
```
- Add
```
type: post
url: localhost:8080/add
body:
{
"name":"Alice",
"para1":"90",
"para2":"90",
"para3":"90"
}
```
