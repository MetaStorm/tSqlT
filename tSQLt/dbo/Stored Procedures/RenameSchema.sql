CREATE PROCEDURE dbo.RenameSchema               

 @OLDNAME  varchar(500),
@NEWNAME  varchar(500)

AS            
     /*check for oldschema exist or not */
     IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name =  @OLDNAME)

        BEGIN

            RETURN

        END

       /* Create the schema with new name */
      IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = @NEWNAME)

      BEGIN

          EXECUTE( 'CREATE SCHEMA ' + @NEWNAME );

       END                

     /* get the object under the old schema and transfer those objects to new schema */
     DECLARE Schema_Cursor CURSOR FOR

    SELECT ' ALTER SCHEMA ' + @NEWNAME + ' TRANSFER '+ SCHEMA_NAME(SCHEMA_ID)+'.'+ name  
    as ALTSQL from sys.objects WHERE type IN ('U','V','P','Fn') AND 
    SCHEMA_NAME(SCHEMA_ID) = @OLDNAME;

   OPEN Schema_Cursor;          

  DECLARE @SQL varchar(500)         

   FETCH NEXT FROM Schema_Cursor INTO @SQL;

   WHILE @@FETCH_STATUS = 0
    BEGIN
    exec (@SQL) 
    FETCH NEXT FROM Schema_Cursor INTO @SQL;
   END;

   CLOSE Schema_Cursor;

   DEALLOCATE Schema_Cursor;

   /* drop the old schema which should be the user schema */
   IF @OLDNAME <> 'dbo' and  @OLDNAME <> 'guest'
   BEGIN
    EXECUTE ('DROP SCHEMA ' + @OLDNAME) 
    END