

CREATE VIEW [dbo].[Notes_vServiceStep]AS
     SELECT ISNULL(BookingCenter,'') BookingCenter,
ISNULL(Category,'') Category,
ISNULL(LEFT(ServiceName,60),'') ServiceName,
ISNULL(StepDescription,'') StepDescription,
ISNULL(StepTeam,'') StepTeam,
ISNULL(StepType,'') StepType,
ISNULL(StepTypePosition,0) StepTypePosition,
ISNULL(ServiceUID,'') ServiceUID,
ISNULL(StepPosition,0) StepPosition,
ISNULL(StepGroup,0) StepGroup,
ISNULL(StepGoal,0) StepGoal,
ISNULL(ProjectKey,'') ProjectKey,
ISNULL(ProjectName,'') ProjectName,
ISNULL(ProjectDescription,'') ProjectDescription
     FROM Notes.vServiceStep;