CREATE TRIGGER connection_limit_trigger
ON ALL SERVER WITH EXECUTE AS 'username'
FOR LOGON
AS
BEGIN
IF ORIGINAL_LOGIN()= 'account which only can loggin from specific host' AND
  (SELECT COUNT(*) FROM sys.dm_exec_sessions
            WHERE [host_name] <> 'computer name for account' AND
                [original_login_name] = 'account name'			
				)> 1
    ROLLBACK;
END;
