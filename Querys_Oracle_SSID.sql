--Registros travados
SELECT b.session_id AS sid,c.serial# AS Serial,NVL(b.oracle_username, '(oracle)') AS username, a.owner AS object_owner,
       a.object_name,Decode(b.locked_mode, 0, 'None',1, 'Null (NULL)',2, 'Row-S (SS)', 3, 'Row-X (SX)',4, 'Share (S)',5, 'S/Row-X (SSX)',6, 'Exclusive (X)',b.locked_mode) locked_mode,
       b.os_user_name
FROM   dba_objects a,v$locked_object b,v$session c
WHERE  a.object_id = b.object_id AND c.sid = '62' AND b.session_id   = c.sid
ORDER BY 1, 2, 3, 4;

--Todas as Sessoes
SELECT NVL(s.username, '(oracle)') AS username,s.osuser,s.sid,s.serial#,p.spid,s.lockwait,s.status,s.module,
       s.machine,s.program,TO_CHAR(s.logon_Time,'DD-MON-YYYY HH24:MI:SS') AS logon_time
  FROM   v$session s, v$process p
WHERE  s.paddr = p.addr
ORDER BY s.username, s.osuser;
