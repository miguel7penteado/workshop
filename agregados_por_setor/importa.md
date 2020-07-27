
```cmd
for /r %x in ( Basico_*.csv ) do copy "%x" basicos_todos\ 

for /r %x in ( Basico_*.csv ) do csvsql --db postgresql://miguel:Acfolley007@172.16.2.50/censo2010-ibge --db-schema br.agregados.setor.censo2010 -e latin1 -v -d ; --locale pt_BR --create-if-not-exists --tables basico --insert  "%x" 

```
