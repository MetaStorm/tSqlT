CREATE FUNCTION fClientAccountDashboard 
(
	@Account sysname
)
RETURNS 
@Table_Var TABLE 
(
	[Source] sysname, 
	[Key] sysname,
	[Value] sysname,
	IsLink bit
)
AS
BEGIN
INSERT INTO @Table_Var
SELECT 'Olympic','IsLinked' [Key], AssociatedRoot Value, 1  IsLink FROM [olympic].[ExternalAccountLink] WHERE ExternalAccount = @Account
INSERT INTO @Table_Var
SELECT 'Olympic','IsOpen',IsOpen ,0 FROM [DataHub].olympic.[vClient] WHERE Root = @Account
INSERT INTO @Table_Var
SELECT 'Pershing','IsOpen',IsOpen ,0 FROM [DataHub].pershing.[vClient] WHERE Root = @Account
	
	RETURN 
END