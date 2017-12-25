CREATE FUNCTION fAccountInfo(
@Account sysname
)RETURNS TABLE AS
RETURN
SELECT 'Olympic.IsLinked' [Key], CAST(AssociatedRoot as sysname) Value, CAST(1 as bit) IsLink FROM [olympic].[ExternalAccountLink] WHERE ExternalAccount = @Account
UNION ALL
SELECT 'Olympic.IsOpen',CAST(IsOpen AS sysname),0 FROM [DataHub].olympic.[vClient] WHERE Root = @Account
UNION ALL
SELECT 'Pershing.IsOpen',CAST(IsOpen AS sysname),0 FROM [DataHub].pershing.[vClient] WHERE Root = @Account