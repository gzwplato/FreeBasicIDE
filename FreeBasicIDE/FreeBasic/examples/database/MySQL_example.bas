#include once "mysql\mysql.bi"

#define NULL 0

dim db as MYSQL ptr
dim dbname as string

db = mysql_init( NULL )

dbname = "tel1"

if( mysql_real_connect( db, "localhost", "auios", "5018", NULL, MYSQL_PORT, NULL, 0 ) = 0 ) then
    print "Can't connect to the mysql server on port"; MYSQL_PORT
    mysql_close( db )
    sleep()
    end 1
end if

if( mysql_select_db( db, dbname ) ) then
    print "Can't select the "; dbname; " database !"
    mysql_close( db )
    sleep()
    end 1
end if

print "Client info: "; *mysql_get_client_info()

print "Host info: "; *mysql_get_host_info( db )
    
print "Server info: "; *mysql_get_server_info( db )

dim res as MYSQL_RES ptr
dim fd as MYSQL_FIELD ptr
dim row as MYSQL_ROW
dim as integer l, x, j, k
dim fields(24) as string
dim rowstr as string

res = mysql_list_tables( db, "%" )
l = 1
x = 0
do
    fd = mysql_fetch_field( res )
    if( fd = NULL ) then
        print "Fetch field"
        exit do
    end if
    
    fields(x) = *fd->name
    do 
        row = mysql_fetch_row( res )
        if( row = NULL ) then
            print "Fetch row"
            exit do
        end if
        
        j = mysql_num_fields( res )
        print "Table #"; l; " :-" 
        l += 1
        for k = 0 to j-1
            print "  Fld #"; k+1; "("+ fields(k) + "): ";
            if( row[k] = NULL ) then
                print "NULL"
            else
                rowstr = *row[k]
                print rowstr
            end if
            print "=============================="
        next 
    loop
    
    mysql_free_result( res )
    x += 1
loop

print mysql_query(db,"SELECT * FROM bookinventory")
res = mysql_store_result(db)
dim as integer numFields = mysql_num_fields(res)

do
    row = mysql_fetch_row(res)
    if(row = NULL) then exit do
    dim as string outputBuilder
    for colIdx as integer = 0 to numFields-1
        outputBuilder+=*row[colIdx]
        outputBuilder+=" | "
    next colIdx
    print outputBuilder
loop

mysql_free_result(res)


mysql_close( db )
sleep()