SELECT sys.objects.type AS                          ObjectType
      ,sys.schemas.name + '.' + sys.objects.name AS ObjectName
  FROM sys.schemas
       INNER JOIN sys.objects
               ON sys.schemas.schema_id = sys.objects.schema_id
 WHERE sys.objects.type IN('FN','IF','P','SN','SO','TF','TR','U','V')
 ORDER BY ObjectType
         ,ObjectName;