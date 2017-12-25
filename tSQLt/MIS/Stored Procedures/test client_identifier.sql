--  Comments here are associated with the test.
--  For test case examples, see: http://tsqlt.org/user-guide/tsqlt-tutorial/
CREATE PROCEDURE [MIS].[test client_identifier]
AS
BEGIN


SELECT * 
FROM MIS.dbo.Client AS C
LEFT OUTER JOIN MIS.dbo.ClientIdentifier CI ON CI.Client = C.ClientNumber
WHERE CI.Identifier IS NULL  
  --  For a complete list, see: http://tsqlt.org/user-guide/assertions/
  EXEC tSQLt.AssertEquals  @Expected = 0,@Actual = @@ROWCOUNT, @Message = N'MIS.dbo.Client has unmatched records in MIS.dbo.ClientIdentifier'

  
END;