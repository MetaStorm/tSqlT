
CREATE VIEW test.[DataHub.B2B.vClient]
AS
SELECT     Root, ClientName, Type, Source, RelationshipManagerID
FROM         DataHub.B2B.vClient
WHERE     (RelationshipManagerID IS NULL) AND (IsOpen = 1)