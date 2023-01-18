alter session set "_oracle_script"=true;  
create user equipos identified by equipos;
GRANT CONNECT, RESOURCE, DBA TO equipos;
