CREATE VIEW [dbo].[Notes_vServiceStep]AS
     SELECT ISNULL(BookingCenter,'') BookingCenter,
ISNULL(Category,'') Category,
ISNULL(ServiceName,'') ServiceName,
ISNULL(StepDescription,'') StepDescription,
ISNULL(StepTeam,'') StepTeam,
ISNULL(StepType,'') StepType,
ISNULL(StepTypePosition,0) StepTypePosition,
ISNULL(ServiceUID,'') ServiceUID,
ISNULL(StepPosition,0) StepPosition,
ISNULL(StepGroup,0) StepGroup,
ISNULL(StepGoal,0) StepGoal,
ISNULL(ProjectKey,0) ProjectKey,
ISNULL(ProjectName,0) ProjectName,
ISNULL(ProjectDescription,0) ProjectDescription


     FROM Notes.vServiceStep ss;