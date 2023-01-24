WITH CTE_Relationships(ReferencedObject
                      ,ReferencingObject)
     AS (SELECT referencedSchema.name + '.' + referencedObject.name AS   ReferencedObject
               ,referencingSchema.name + '.' + referencingObject.name AS ReferencingObject
           FROM sys.sql_expression_dependencies
                INNER JOIN sys.objects AS referencedObject
                        ON sys.sql_expression_dependencies.referenced_id = referencedObject.object_id
                INNER JOIN sys.schemas AS referencedSchema
                        ON referencedObject.schema_id = referencedSchema.schema_id
                INNER JOIN sys.objects AS referencingObject
                        ON sys.sql_expression_dependencies.referencing_id = referencingObject.object_id
                INNER JOIN sys.schemas AS referencingSchema
                        ON referencingObject.schema_id = referencingSchema.schema_id
          WHERE referencingObject.type IN('FN','IF','P','SN','SO','TF','TR','U','V')
                AND referencedObject.type IN('FN','IF','P','SN','SO','TF','TR','U','V')
         UNION
         SELECT referencedSchema.name + '.' + referencedTable.name AS   ReferencedObject
               ,referencingSchema.name + '.' + referencingTable.name AS ReferencingObject
           FROM sys.foreign_keys
                INNER JOIN sys.tables AS referencingTable
                        ON sys.foreign_keys.parent_object_id = referencingTable.object_id
                INNER JOIN sys.schemas AS referencingSchema
                        ON referencingTable.schema_id = referencingSchema.schema_id
                INNER JOIN sys.tables AS referencedTable
                        ON sys.foreign_keys.referenced_object_id = referencedTable.object_id
                INNER JOIN sys.schemas AS referencedSchema
                        ON referencedTable.schema_id = referencedSchema.schema_id)
     SELECT DISTINCT
            ReferencedObject
           ,ReferencingObject
       FROM CTE_Relationships
      WHERE ReferencedObject <> ReferencingObject
      ORDER BY ReferencedObject
              ,ReferencingObject;