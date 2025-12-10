CREATE TABLE [User] (
	[id] int IDENTITY(1,1) NOT NULL UNIQUE,
	[UserName] nvarchar(10) NOT NULL UNIQUE,
	[FirstName] nvarchar(100) NOT NULL UNIQUE,
	[LastName] nvarchar(100) NOT NULL UNIQUE,
	[Password] nvarchar(max) NOT NULL UNIQUE,
	[Email] nvarchar(max) NOT NULL UNIQUE,
	[Phone] nvarchar(10) NOT NULL,
	[Gender] bit NOT NULL UNIQUE,
	[CreateAt] datetime NOT NULL,
	[CreateBy] int NOT NULL UNIQUE,
	[UpdateAt] datetime NOT NULL,
	[UpdateBy] int NOT NULL,
	[IsDelete] bit NOT NULL,
	[ClassId] int,
	[DepartmentId] int NOT NULL,
	PRIMARY KEY ([id])
);

CREATE TABLE [Class] (
	[id] int IDENTITY(1,1) NOT NULL UNIQUE,
	[ClassName] nvarchar(max) NOT NULL,
	[DepartmentID] int NOT NULL,
	[Year] nvarchar(max) NOT NULL,
	PRIMARY KEY ([id])
);

CREATE TABLE [Departments] (
	[id] int IDENTITY(1,1) NOT NULL UNIQUE,
	[DepartmentName] nvarchar(max) NOT NULL,
	PRIMARY KEY ([id])
);

CREATE TABLE [Event] (
	[id] int IDENTITY(1,1) NOT NULL UNIQUE,
	[DateStart] datetime NOT NULL,
	[DateEnd] datetime NOT NULL,
	[Despcription] int NOT NULL,
	[SemestersId] int NOT NULL,
	[QRCode] nvarchar(max) NOT NULL,
	[Scope] nvarchar(max) NOT NULL,
	[DepartmentId] int NOT NULL,
	[QRExpirationTime] datetime NOT NULL,
	[CreatedByUserId] int NOT NULL,
	PRIMARY KEY ([id])
);

CREATE TABLE [CriteriaCategories] (
	[id] int IDENTITY(1,1) NOT NULL UNIQUE,
	[Name] int NOT NULL,
	PRIMARY KEY ([id])
);

CREATE TABLE [CriteriaItems] (
	[id] int IDENTITY(1,1) NOT NULL UNIQUE,
	[Name] nvarchar(max) NOT NULL,
	[CriteriaCategoryId] int NOT NULL,
	[Score] int NOT NULL,
	PRIMARY KEY ([id])
);

CREATE TABLE [EventAttendances] (
	[id] int IDENTITY(1,1) NOT NULL UNIQUE,
	[UserId] int NOT NULL,
	[EvenId] int NOT NULL,
	[Scanned_at] datetime NOT NULL,
	[IsVerified] bit NOT NULL,
	[location] nvarchar(max) NOT NULL,
	[note] nvarchar(max) NOT NULL,
	[SelfEvaluati] nvarchar(max) NOT NULL,
	[FinalEvaluation] nvarchar(max) NOT NULL,
	PRIMARY KEY ([id])
);

CREATE TABLE [Roles] (
	[id] int IDENTITY(1,1) NOT NULL UNIQUE,
	[RoleName] nvarchar(max) NOT NULL,
	PRIMARY KEY ([id])
);

CREATE TABLE [UserRoles] (
	[id] int IDENTITY(1,1) NOT NULL UNIQUE,
	[UserId] int NOT NULL,
	[RoleId] int NOT NULL,
	PRIMARY KEY ([id])
);

CREATE TABLE [Permissions] (
	[id] int IDENTITY(1,1) NOT NULL UNIQUE,
	[Name] int NOT NULL,
	[Description] int NOT NULL,
	PRIMARY KEY ([id])
);

CREATE TABLE [RolePermission] (
	[id] int IDENTITY(1,1) NOT NULL UNIQUE,
	[RoleID] int NOT NULL,
	[Permission] int NOT NULL,
	PRIMARY KEY ([id])
);

CREATE TABLE [Semesters] (
	[id] int IDENTITY(1,1) NOT NULL UNIQUE,
	[Name] int NOT NULL,
	PRIMARY KEY ([id])
);

CREATE TABLE [StudentScores] (
	[id] int IDENTITY(1,1) NOT NULL UNIQUE,
	[UserId] int NOT NULL,
	[SemesterId] int NOT NULL,
	[score] float(53) NOT NULL,
	[CriteriaId] int NOT NULL,
	PRIMARY KEY ([id])
);

CREATE TABLE [ScoreLogs] (
	[id] int IDENTITY(1,1) NOT NULL UNIQUE,
	[UserId] int NOT NULL,
	[SemesterId] int NOT NULL,
	[CriteriaId] int NOT NULL,
	[old_score] float(53) NOT NULL,
	[new_score] float(53) NOT NULL,
	[reason] nvarchar(max) NOT NULL,
	[updated_by_user_id] int NOT NULL,
	[updated_at] datetime NOT NULL,
	PRIMARY KEY ([id])
);

ALTER TABLE [User] ADD CONSTRAINT [User_fk13] FOREIGN KEY ([ClassId]) REFERENCES [Class]([id]);

ALTER TABLE [User] ADD CONSTRAINT [User_fk14] FOREIGN KEY ([DepartmentId]) REFERENCES [Departments]([id]);


ALTER TABLE [Event] ADD CONSTRAINT [Event_fk4] FOREIGN KEY ([SemestersId]) REFERENCES [Semesters]([id]);

ALTER TABLE [Event] ADD CONSTRAINT [Event_fk7] FOREIGN KEY ([DepartmentId]) REFERENCES [Departments]([id]);

ALTER TABLE [Event] ADD CONSTRAINT [Event_fk9] FOREIGN KEY ([CreatedByUserId]) REFERENCES [User]([id]);

ALTER TABLE [CriteriaItems] ADD CONSTRAINT [CriteriaItems_fk2] FOREIGN KEY ([CriteriaCategoryId]) REFERENCES [CriteriaCategories]([id]);
ALTER TABLE [EventAttendances] ADD CONSTRAINT [EventAttendances_fk1] FOREIGN KEY ([UserId]) REFERENCES [User]([id]);

ALTER TABLE [EventAttendances] ADD CONSTRAINT [EventAttendances_fk2] FOREIGN KEY ([EvenId]) REFERENCES [Event]([id]);

ALTER TABLE [UserRoles] ADD CONSTRAINT [UserRoles_fk1] FOREIGN KEY ([UserId]) REFERENCES [User]([id]);

ALTER TABLE [UserRoles] ADD CONSTRAINT [UserRoles_fk2] FOREIGN KEY ([RoleId]) REFERENCES [Roles]([id]);

ALTER TABLE [RolePermission] ADD CONSTRAINT [RolePermission_fk1] FOREIGN KEY ([RoleID]) REFERENCES [Roles]([id]);

ALTER TABLE [RolePermission] ADD CONSTRAINT [RolePermission_fk2] FOREIGN KEY ([Permission]) REFERENCES [Permissions]([id]);

ALTER TABLE [StudentScores] ADD CONSTRAINT [StudentScores_fk1] FOREIGN KEY ([UserId]) REFERENCES [User]([id]);

ALTER TABLE [StudentScores] ADD CONSTRAINT [StudentScores_fk2] FOREIGN KEY ([SemesterId]) REFERENCES [Semesters]([id]);

ALTER TABLE [StudentScores] ADD CONSTRAINT [StudentScores_fk4] FOREIGN KEY ([CriteriaId]) REFERENCES [CriteriaItems]([id]);
ALTER TABLE [ScoreLogs] ADD CONSTRAINT [ScoreLogs_fk1] FOREIGN KEY ([UserId]) REFERENCES [User]([id]);

ALTER TABLE [ScoreLogs] ADD CONSTRAINT [ScoreLogs_fk2] FOREIGN KEY ([SemesterId]) REFERENCES [Semesters]([id]);

ALTER TABLE [ScoreLogs] ADD CONSTRAINT [ScoreLogs_fk3] FOREIGN KEY ([CriteriaId]) REFERENCES [CriteriaItems]([id]);

ALTER TABLE [ScoreLogs] ADD CONSTRAINT [ScoreLogs_fk7] FOREIGN KEY ([updated_by_user_id]) REFERENCES [User]([id]);