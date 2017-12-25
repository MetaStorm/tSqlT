--  Comments here are associated with the test.
--  For test case examples, see: http://tsqlt.org/user-guide/tsqlt-tutorial/
CREATE PROCEDURE [olympic].[test BookBuilding: FDBTAB]
AS
BEGIN
  --Assemble
  --  This section is for code that sets up the environment. It often
  --  contains calls to methods such as tSQLt.FakeTable and tSQLt.SpyProcedure
  --  along with INSERTs of relevant data.
  --  For more information, see http://tsqlt.org/user-guide/isolating-dependencies/
  
  --Act
  --  Execute the code under test like a stored procedure, function or view
  --  and capture the results in variables or tables.
  DECLARE @Count int = (SELECT COUNT(*) FROM Bookbuilding.olympic.FDBTAB)
	DECLARE @OK bit = CASE WHEN @Count < 1000 THEN 0 ELSE 1 END
	DECLARE @Error VARCHAR(max) = CONCAT('Olympic''s FDBTAB table has only ',@Count,' records @ ',GETDATE())
  --Assert
  --  Compare the expected and actual values, or call tSQLt.Fail in an IF statement.  
  --  Available Asserts: tSQLt.AssertEquals, tSQLt.AssertEqualsString, tSQLt.AssertEqualsTable
  --  For a complete list, see: http://tsqlt.org/user-guide/assertions/
	IF @OK = 0
  EXEC tSQLt.Fail @Error -- nvarchar(max)
  
  
END;