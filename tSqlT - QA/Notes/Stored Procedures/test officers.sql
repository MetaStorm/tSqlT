--  Comments here are associated with the test.
--  For test case examples, see: http://tsqlt.org/user-guide/tsqlt-tutorial/
CREATE PROCEDURE [Notes].[test officers]
AS
BEGIN
SELECT ipbID, COUNT(*) AS Expr1
FROM DataHub.Notes.Source_UOfficers
GROUP BY ipbID
HAVING      (COUNT(*) > 1)
EXEC tSQLt.AssertEquals  @Expected = 0,@Actual = @@ROWCOUNT, @Message = N'DataHub.Notes.Source_UOfficers has duplicated ipbIDs'
  
END;