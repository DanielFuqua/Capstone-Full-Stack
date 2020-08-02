USE [master]
GO

IF db_id('Capstone') IS NULL
  CREATE DATABASE Capstone
GO

USE [Capstone]
GO


DROP TABLE IF EXISTS [UserPoseDifficulty];
DROP TABLE IF EXISTS [Instruction];
DROP TABLE IF EXISTS [Modification];
DROP TABLE IF EXISTS [Benefit];
DROP TABLE IF EXISTS [Vocabulary];
DROP TABLE IF EXISTS [Comment];
DROP TABLE IF EXISTS [Note];
DROP TABLE IF EXISTS [Pose];
DROP TABLE IF EXISTS [UserProfile];
DROP TABLE IF EXISTS [UserType];

GO 


CREATE TABLE [UserType] (
  [Id] INTEGER IDENTITY PRIMARY KEY NOT NULL,
  [Name] NVARCHAR(50) NOT NULL
)

CREATE TABLE [UserProfile] (
  [Id] INTEGER IDENTITY PRIMARY KEY NOT NULL,
  [FirebaseUserId] NVARCHAR(28) NOT NULL,
  [DisplayName] NVARCHAR(50) NOT NULL,
  [Email] NVARCHAR(255) NOT NULL,
  [UserTypeId] INTEGER NOT NULL,

  CONSTRAINT FK_UserProfile_UserType FOREIGN KEY (UserTypeId) REFERENCES UserType(Id),
  CONSTRAINT UQ_FirebaseUserId UNIQUE(FirebaseUserId)
)

CREATE TABLE [Pose] (
  [Id] INTEGER IDENTITY PRIMARY KEY NOT NULL,
  [NameEnglish] NVARCHAR(50) NOT NULL,
  [NameSanskrit] NVARCHAR(50),
  [ImageLocation] NVARCHAR(200),
  [Drishti] NVARCHAR(50)
)


CREATE TABLE [Note] (
  [Id] INTEGER IDENTITY PRIMARY KEY NOT NULL,
  [PoseId] INTEGER NOT NULL,
  [UserProfileId] INTEGER NOT NULL,
  [Content] NVARCHAR(500) NOT NULL,
  [CreateDateTime] DATETIME NOT NULL,

  CONSTRAINT FK_Note_UserProfile FOREIGN KEY (UserProfileId) REFERENCES UserProfile(id),
  CONSTRAINT FK_Note_Pose FOREIGN KEY (PoseId) REFERENCES Pose(id)
)

CREATE TABLE [Comment] (
  [Id] INTEGER IDENTITY PRIMARY KEY NOT NULL,
  [PoseId] INTEGER NOT NULL,
  [UserProfileId] INTEGER NOT NULL,
  [Content] NVARCHAR(500) NOT NULL,
  [CreateDateTime] DATETIME NOT NULL,

  CONSTRAINT FK_Comment_UserProfile FOREIGN KEY (UserProfileId) REFERENCES UserProfile(id),
  CONSTRAINT FK_Comment_Pose FOREIGN KEY (PoseId) REFERENCES Pose(id)
)


CREATE TABLE [Vocabulary] (
  [Id] INTEGER IDENTITY PRIMARY KEY NOT NULL,
  [Term] NVARCHAR(50) NOT NULL,
  [Definition] NVARCHAR(250) NOT NULL
)

CREATE TABLE [Benefit] (
  [Id] INTEGER IDENTITY PRIMARY KEY NOT NULL,
  [PoseId] INTEGER NOT NULL,
  [Content] NVARCHAR(MAX) NOT NULL,

  CONSTRAINT FK_Benefit_Pose FOREIGN KEY (PoseId) REFERENCES Pose(id)

)

CREATE TABLE [Modification] (
  [Id] INTEGER IDENTITY PRIMARY KEY NOT NULL,
  [PoseId] INTEGER NOT NULL,
  [Content] NVARCHAR(MAX) NOT NULL,

  CONSTRAINT FK_Modification_Pose FOREIGN KEY (PoseId) REFERENCES Pose(id)

)

CREATE TABLE [Instruction] (
  [Id] INTEGER IDENTITY PRIMARY KEY NOT NULL,
  [PoseId] INTEGER NOT NULL,
  [Content] NVARCHAR(MAX) NOT NULL,

  CONSTRAINT FK_Instruction_Pose FOREIGN KEY (PoseId) REFERENCES Pose(id)

)

CREATE TABLE [UserPoseDifficulty] (
   [Id] INTEGER IDENTITY PRIMARY KEY NOT NULL,
   [UserProfileId] INTEGER NOT NULL,
   [PoseId] INTEGER NOT NULL,
   [Difficulty] INTEGER NOT NULL,

   CONSTRAINT FK_UserPoseDifficulty_Pose FOREIGN KEY (PoseId) REFERENCES Pose(id),
   CONSTRAINT FK_UserPoseDifficulty_UserProfile FOREIGN KEY (UserProfileId) REFERENCES UserProfile(id)
)

GO


SET IDENTITY_INSERT [UserType] ON
INSERT INTO [UserType]
  ([Id], [Name])
VALUES 
  (1, 'admin'), 
  (2, 'user');
SET IDENTITY_INSERT [UserType] OFF
  

SET IDENTITY_INSERT [UserProfile] ON
INSERT INTO [UserProfile]
  ([Id], [FirebaseUserId], [DisplayName], [Email], [UserTypeId])
VALUES
  (1, 'UklaapcMPoPOjvdu7WvpIrsLxZW2', 'newYogi89', 'newYogi@gmail.com', 2),
  (2, 'D6FdCiMwzYNrlegMJLzliHPJYKH2', 'fooBarzonian', 'barzonian@gmail.com', 2),
  (3, 'SIoXjFdhc9aTwiKNIRVEgdW88lX2', 'stretch', 'stretch@gmail.com', 2),
  (4, 'nRlCJkn94tSeBR2MQFo8fAn68eE3', 'claudia', 'claudia@gmail.com', 1),
  (5, 'unNLekIrIpPC0LRMLmOfZbMQ34o1', 'lindseyInstructor', 'lindz@gmail.com', 2),
  (6, 'HfMcbFa38KhRVa75sIHyr3fK5Bp2', 'backBender', 'bender@gmail.com', 2),
  (7, 'E6beAFZVTcYSJfJ676xT1AOhNxL2', 'yogaLove', 'yogaLove@gmail.com', 2),
  (8, 'KyR4TTSyM1Ser0vT9WnERD2YeI83', 'newbie11', 'newbie@gmail.com', 2),
  (9, 'nFyAqJbqd1Y26eSuGOc7d4H5SCh2', 'NashvilleYogi', 'nashyogi@gmail.com', 2),
  (10, '8IqX56dMAXhbCAxaLHx2ewVEyao1', 'yinYogaAdam', 'yin@gmail.com', 1);
SET IDENTITY_INSERT [UserProfile] OFF

SET IDENTITY_INSERT [Note] ON
INSERT INTO [Note]
  ([Id], [PoseId], [UserProfileId], [Content], [CreateDateTime])
VALUES
  (1, 1, 1, 'I love this breathing exercise.', '2020-07-31 20:30:30');
SET IDENTITY_INSERT [Note] OFF


SET IDENTITY_INSERT [Pose] ON
INSERT INTO [Pose]
  ([Id], [NameEnglish], [NameSanskrit], [ImageLocation], [Drishti])
VALUES
  (1, 'Standing Deep Breathing', 'Pranayama', 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/french-bulldog-in-yoga-pose-warrior-3-royalty-free-image-525986255-1536177884.jpg', null),
  (2, 'Half Moon Pose with Hands-to-Feet', 'Ardha Chandrasana with Padahastasana', 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/french-bulldog-in-yoga-pose-warrior-3-royalty-free-image-525986255-1536177884.jpg', null),
  (3, 'Awkward Pose', 'Utkatasana', 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/french-bulldog-in-yoga-pose-warrior-3-royalty-free-image-525986255-1536177884.jpg', null), 
  (4, 'Eagle Pose', 'Garudasana', 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/french-bulldog-in-yoga-pose-warrior-3-royalty-free-image-525986255-1536177884.jpg', null),
  (5, 'Standing Knee-to-Head', 'Dandayamana Janushirasana', 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/french-bulldog-in-yoga-pose-warrior-3-royalty-free-image-525986255-1536177884.jpg', null),
  (6, 'Standing Bow Pose', 'Dandayamana Danyurasana', 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/french-bulldog-in-yoga-pose-warrior-3-royalty-free-image-525986255-1536177884.jpg', null),
  (7, 'Balancing Stick Pose', 'Tuladandasana', 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/french-bulldog-in-yoga-pose-warrior-3-royalty-free-image-525986255-1536177884.jpg', null),
  (8, 'Standing Separtate-Leg Stretching Pose', 'Dandayamana Bibhaktapada Paschimottanasana', 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/french-bulldog-in-yoga-pose-warrior-3-royalty-free-image-525986255-1536177884.jpg', null),
  (9, 'Triangle Pose', 'Trikanasana', 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/french-bulldog-in-yoga-pose-warrior-3-royalty-free-image-525986255-1536177884.jpg', null),
  (10, 'Standing Separate Leg Head-to-Knee', 'Dandayamana Bibhaktapada Janushirasana', 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/french-bulldog-in-yoga-pose-warrior-3-royalty-free-image-525986255-1536177884.jpg', null),
  (11, 'Tree', 'Tadasana', 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/french-bulldog-in-yoga-pose-warrior-3-royalty-free-image-525986255-1536177884.jpg', null),
  (12, 'Toe Stand', 'Padangustasana', 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/french-bulldog-in-yoga-pose-warrior-3-royalty-free-image-525986255-1536177884.jpg', null),
  (13, 'Corpse Pose', 'Savasana', 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/french-bulldog-in-yoga-pose-warrior-3-royalty-free-image-525986255-1536177884.jpg', null),
  (14, 'Wind Removing Pose', 'Pavanamuktasana', 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/french-bulldog-in-yoga-pose-warrior-3-royalty-free-image-525986255-1536177884.jpg', null),
  (15, 'Sit-Up', null, 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/french-bulldog-in-yoga-pose-warrior-3-royalty-free-image-525986255-1536177884.jpg', null),
  (16, 'Cobra', 'Bhujangasana', 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/french-bulldog-in-yoga-pose-warrior-3-royalty-free-image-525986255-1536177884.jpg', null),
  (17, 'Locust', 'Salabhasana', 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/french-bulldog-in-yoga-pose-warrior-3-royalty-free-image-525986255-1536177884.jpg', null), 
  (18, 'Full Locust', 'Poorna Salabhasana', 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/french-bulldog-in-yoga-pose-warrior-3-royalty-free-image-525986255-1536177884.jpg', null),
  (19, 'Floor Bow Pose', 'Dhanurasana', 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/french-bulldog-in-yoga-pose-warrior-3-royalty-free-image-525986255-1536177884.jpg', null),
  (20, 'Fixed Firm', 'Supta Vajrasana','https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/french-bulldog-in-yoga-pose-warrior-3-royalty-free-image-525986255-1536177884.jpg', null),
  (21, 'Half Tortoise', 'Ardha Kurmasana',' https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/french-bulldog-in-yoga-pose-warrior-3-royalty-free-image-525986255-1536177884.jpg', null),
  (22, 'Camel', 'Ustrasana', 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/french-bulldog-in-yoga-pose-warrior-3-royalty-free-image-525986255-1536177884.jpg', null),
  (23, 'Rabbit', 'Sasangasana', 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/french-bulldog-in-yoga-pose-warrior-3-royalty-free-image-525986255-1536177884.jpg', null),
  (24, 'Head-to-Knee With Stretching', ' Janushirasana with Paschimottanasana', 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/french-bulldog-in-yoga-pose-warrior-3-royalty-free-image-525986255-1536177884.jpg', null),
  (25, 'Spine Twisting', 'Ardha Matsyendrasana', 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/french-bulldog-in-yoga-pose-warrior-3-royalty-free-image-525986255-1536177884.jpg', null),
  (26, 'Blowing In Firm', 'Kapalbhati-in-Vajrasana', 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/french-bulldog-in-yoga-pose-warrior-3-royalty-free-image-525986255-1536177884.jpg', null);
SET IDENTITY_INSERT [Pose] OFF


SET IDENTITY_INSERT [Benefit] ON
INSERT INTO [Benefit]
  ([Id], [PoseId], [Content])
VALUES
  (1, 1, 'Expands your lungs and help transfer as much oxygen to your muscles and organs as possible'),
  (2, 1, 'Improves detoxification of the organs'),
  (3, 1, 'Increases mental relaxation as well as blood flow, sending blood to parts of the body that will need it most'),
  (4, 2, 'Strengthens thighs, calves, and all of body’s central muscles'),
  (5, 2, 'Increases your spinal flexibility'),
  (6, 2, 'Firms and trims abdomen, buttocks, hips, and waistline'),
  (7, 3, 'Helps with chronically cold feet'),
  (8, 3, 'Circulates fresh blood to knees and ankles'),
  (9, 3, 'Strengthens and firms all muscles of legs and upper arms'),
  (10, 3, 'Increases hip flexibility and relieves muscular aches and cramps'),
  (11, 3, 'Helps to alleviate slipped discs and other lower-spine problems'),
  (12, 4, 'Works into 12 major joints of body'),
  (13, 4, 'Warms body and readies joints for next 3 poses'),
  (14, 4, 'Improves balance'),
  (15, 4, 'Improves hip-joint mobility'),
  (16, 4, 'Strengthens deltoid, trapezius, and legs'),
  (17, 5, 'Works all major muscle groups'),
  (18, 5, 'Tightens abdominal and thigh muscles'),
  (19, 5, 'Increases flexibility of sciatic nerves'),
  (20, 5, 'Strengthens the following: Tendons, hamstrings, and biceps of thigh muscles; Biceps, triceps, deltoids, trapezius, back muscles, latissimus dorsi, and scapula'),
  (21, 5, 'Improves concentration and builds mental strength'),
  (22, 6, 'Exemplifies “tourniquet” effect in Bikram Yoga because this pose transfers circulation from 1 side of body to other side and then equalizes circulation'),
  (23, 6, 'Improves flexibility and strength of most of body’s muscles'),
  (24, 6, 'Opens shoulder joints and diaphragm'),
  (25, 6, 'Eases frozen-shoulder conditions'),
  (26, 6, 'Firms abdominal wall and upper thighs'),
  (27, 6, 'Increases elasticity and size of lungs and rib cage'),
  (28, 6, 'Improves flexibility and strength of lower spine'),
  (29, 6, 'Improves concentration and builds mental strength'),
  (30, 6, 'Develops balance'),
  (31, 6, 'Improves concentration and builds mental strength'),
  (32, 7, 'Strengthens your core and back muscles'),
  (33, 7, 'Gently stretches the entire spinal column'),
  (34, 7, 'Refines control and balance'),
  (35, 7, 'Improves posture'),
  (36, 7, 'Offers many benefits for legs that standing head-to-knee pose also offers'),
  (37, 8, 'Boosts circulation to brain and to adrenal glands'),
  (38, 8, 'Increases flexibility of bottom 5 vertebrae'),
  (39, 8, 'Enhances flexibility and muscle tone of ankles, calves, thighs, pelvis, and hip joints'),
  (40, 8, 'Releases lower back'),
  (41, 8, 'Alleviates sciatica'),
  (42, 9, 'Stretches both sides of body'),
  (43, 9, 'Opens and increases flexibility of hip joints'),
  (44, 9, 'Opens shoulder joint and alleviates frozen shoulder'),
  (45, 9, 'Strengthens and tones buttocks and legs'),
  (46, 9, 'Works all muscle groups simultaneously'),
  (47, 10, 'Enhances flexibility of calves, hamstrings, sciatic nerves, and erectors'),
  (48, 10, 'Throat and abdomen will be heavily compressed, helping stimulate blood flow to the area and flushing out many of your organs including the stomach, liver and spleen'),
  (49, 10, 'Your abdominal muscles will become stronger, as will the muscles in your upper legs (the thighs in particular)'),
  (50, 10, 'Stretches the shoulder area, reducing any pain and mobility issues you might be having, particularly where the trapezius and deltoid muscles are concerned'),
  (51, 11, 'Prepares body for Locust pose when combined with Toe Stand pose'),
  (52, 11, 'Relieves lower-back pain'),
  (53, 11, 'Releases tension in belly'),
  (54, 11, 'Stretches spine and adductors along inner thigh'),
  (55, 11, 'Improves balance and posture'),
  (56, 11, 'Increases flexibility of ankles, knees, and hip joints'),
  (57, 11, 'Enhances mobility of knees and hip'),
  (58, 11, 'Invigorates Internal oblique muscles and leg muscles–particularly calves and quadriceps'),
  (59, 12, 'Helps relieve arthritis in hips and in all leg joints'),
  (60, 12, 'Strengthens joints, stomach muscle, biceps, triceps, and shoulder'),
  (61, 12, 'Invigorates ankles, feet, and knees–especially effective for curing gout and rheumatism'),
  (62, 12, 'Builds balance, concentration, core strength, focus, and patience'),
  (63, 12, 'Prepares body for relaxation and stillness of next pose'),
  (64, 13, 'Maximizes release of tension by completely relaxing entire body'),
  (65, 13, 'Optimizes circulation of freshly oxygenated blood to all areas of body'),
  (66, 13, 'Slows heart rate'),
  (67, 14, 'Cures and prevents flatulence'),
  (68, 14, 'Alleviates most chronic abdominal discomforts'),
  (69, 14, 'Relieves lower back pain'),
  (70, 14, 'Stretches shoulders and entire back side of spine'),
  (71, 14, 'Improves flexibility of hip joints'),
  (72, 14, 'Strengthens biceps and hand muscles'),
  (73, 15, 'Realigns spine and enhances its flexibility'),
  (74, 15, 'Increases flexibility of hamstrings'),
  (75, 15, 'Massages abdominal organs'),
  (76, 15, 'Strengthens and tightens abdominal muscles'),
  (77, 15, 'Tones torso'),
  (78, 15, 'Energizes body to prepare it for next pose'),
  (79, 16, 'Prevents lower back pain'),
  (80, 16, 'Relieves menstrual problems, such as backaches, cramps, and irregularity'),
  (81, 16, 'Increases spinal flexibility and strength'),
  (82, 16, 'Massages and tones back muscles'),
  (83, 17, 'Includes all benefits of Cobra pose'),
  (84, 17, 'Encourages concentration and perseverance'),
  (85, 17, 'Targets upper back'),
  (86, 17, 'Helps treat spinal problems including slipped discs, sciatica, and gout'),
  (87, 17, 'Alleviates tennis elbow'),
  (88, 17, 'Firms hips, buttocks, and legs'),
  (89, 17, 'Strengthens shoulders, pectorals, elbows, wrists, and spine'),
  (90, 17, 'Builds core strength'),
  (91, 18, 'Increases spinal strength and flexibility'),
  (92, 18, 'Firms muscles of thighs, hips, abdomen, and upper arms'),
  (93, 18, 'Strengthens deltoids and trapezius'),
  (94, 18, 'Includes benefits of Standing Bow-Pulling pose'),
  (95, 19, 'Works entire spine'),
  (96, 19, 'Improves oxygen intake by opening rib cage; this enables maximum expansion of lungs'),
  (97, 19, 'Opens shoulder joint'),
  (98, 19, 'Helps correct posture'),
  (99, 19, 'Develops internal balance and harmony'),
  (100, 19, 'Stretches hip flexors and psoas muscle'),
  (101, 19, 'Strengthens abdominal muscles, hips, thighs, and upper arms'),
  (102, 20, 'Stretches into diaphragm and hip joints'),
  (103, 20, 'Helps alleviate gout, rheumatism, and sciatica in legs'),
  (104, 20, 'Lubricates and increases circulation to joints'),
  (105, 20, 'Relieves lower back pain'),
  (106, 20, 'Lengthens and invigorates abdominal muscles'),
  (107, 20, 'Strengthens and enhances flexibility of ankles, knees, and lower back'),
  (108, 21, 'Stretches spine, hips, and gluteal muscles'),
  (109, 21, 'Increases flexibility in hips'),
  (110, 21, 'Strengthens abdomen'),
  (111, 21, 'Improves flexibility of deltoids, latissimus dorsi muscles, scapula, and triceps'),
  (112, 22, 'Relieves back problems by compressing spine'),
  (113, 22, 'Stimulates nervous system'),
  (114, 22, 'Improves neck flexion'),
  (115, 22, 'Opens shoulders, rib cage, lungs, and digestive system'),
  (116, 22, 'Strengthens back and shoulder muscles'),
  (117, 22, 'Invigorates and improves flexibility of neck and spine–especially thoracic spine'),
  (118, 23, 'Balances out spine and releases tension after doing previous pose–Camel pose'),
  (119, 23, 'Prepares body to do final 2 poses'),
  (120, 23, 'Enhances mobility and elasticity of back muscles and spine'),
  (121, 23, 'Improves flexibility of scapula and trapezius'),
  (122, 24, 'Improves concentration and mental endurance'),
  (123, 24, 'Expands solar plexus'),
  (124, 24, 'Enhances flexibility of ankles, knees, hip joints, and sciatic nerves'),
  (125, 24, 'Stretches deltoids, trapezius, and hamstrings, particularly erector femoris'),
  (126, 24, 'Extends lower back, especially last 5 vertebrae'),
  (127, 24, 'Strengthens biceps and quadriceps'),
  (128, 25, 'Creates equilibrium in spine and in left and right side of body'),
  (129, 25, 'Compresses and stretches spine from bottom to top'),
  (130, 25, 'Twists and rinses out spine'),
  (131, 25, 'Boosts and enhances elasticity, flexibility, circulation, and nutrition to spinal nerves, veins, and tissues'),
  (132, 25, 'Relieves lower back pain'),
  (133, 25, 'Increases flexibility of hip joints and back'),
  (134, 25, 'Stretches chest, upper back, and outer thigh muscles'),
  (135, 25, 'Strengthens abdominal muscles and buttocks'),
  (136, 25, 'Opens shoulder joint');
SET IDENTITY_INSERT [Benefit] OFF


SET IDENTITY_INSERT [Instruction] ON
INSERT INTO [Instruction]
  ([Id], [PoseId], [Content])
VALUES
  (1, 1, 'Make sure to breath slowly as this will facilitate lung expansion'),
  (2, 1, 'Keep your back straight all the time and do not bend backwards. This will be easier to achieve if you suck your belly in so that your rib cage protrudes a bit'),
  (3, 1, 'As you exhale, tilt your head back slightly, while keeping your eyes open'),
  (4, 1, 'Shoulders should be kept in line with hips. Hips should be kept forward (you’ll achieve this by slightly squeezing your buttocks)'),
  (5, 1, 'When exhaling, make sure to breath out completely to get rid of every bit of CO2 in your lungs'),
  (6, 1, 'Don’t worry if you feel a little dizzy during this pose or if you feel a slight pinch in the shoulder area – these are completely normal symptoms and indicate that you are doing things right'),
  (7, 2, 'Lock arms and fully engage arm muscles'),
  (8, 2, 'Straighten body towards ceiling'),
  (9, 2, 'While bending backwards, evenly distribute this bend over all of your spine'),
  (10, 2, 'During Hands-to-Feet pose, glue body to legs and move elbows as close to each other as possible behind calf muscles'),
  (11, 2, 'Lift hips up towards ceiling while moving face increasingly further down your shins'),
  (12, 3, 'Maintain 6-inch gap between knees and hands while keeping them parallel to floor'),
  (13, 3, 'Ensure that shoulders stay down by relaxing them throughout all 3 stages of this pose'),
  (14, 3, 'Ease exhaustion by focusing on stretching arms out'),
  (15, 3, 'Keep fingers together'),
  (16, 3, 'Breathe at normal pace'),
  (17, 4, 'Begin with feet together and raise both arms above your hand, and then slowly attempt to hook your right arm underneath the left one at elbow level. If you can and if your flexibility allows for it, cross your fingers together in both palms.'),
  (18, 4, 'Get into a half-squat position'),
  (19, 4, 'Slowly bring your right leg over the left one and around it; your goal is to try and place your right foot on the calf muscle of your left leg'),
  (20, 4, 'Bring your shoulders to the back, which will open up many different joints in the shoulder area, and then push your body slightly upwards from the chest'),
  (21, 5, 'Stand straight with your feet together'),
  (22, 5, 'Form a cup with your palms by interlocking your fingers'),
  (23, 5, 'Bend at your waist and lift your right leg up towards your chest by bending at the knees and cupping your palms around the sole of your foot'),
  (24, 5, 'Slowly straighten your right leg, taking your hands with it'),
  (25, 5, 'Bend your torso further, making your chest touch the knee of your right leg'),
  (26, 5, 'Tuck chin to chest, round spine, and touch forehead to knee'),
  (27, 6, 'Begin by standing with both your feet next to each other, and bend your right leg so that your heel moves towards your buttocks'),
  (28, 6, 'Use your right arm to grab the raised foot behind your back. Grab the leg from the inner side of the body, at around ankle height'),
  (29, 6, 'Extend your left arm upwards so that it points directly at the ceiling'),
  (30, 6, 'Kick back with your raised leg and, at the same time, lean forward with your body'),
  (31, 6, 'The leg you are standing on must remain straight at all times, and you must never let go of your rising leg'),
  (32, 6, 'The ultimate goal is to lift your arm so high that it becomes perpendicular to the floor'),
  (33, 7, 'Start by lifting your arms above your head and pointing them towards the ceiling. Your arm muscles should be kept tight and your elbows locked. Interlock all your fingers while making sure to keep your index fingers pointed outwards'),
  (34, 7, 'Arch your lower back slightly while pushing your hips forward'),
  (35, 7, 'Take a big step forward with your right leg, immediately locking it at the knee as soon as it touches the ground (the left leg remains back in place)'),
  (36, 7, 'Using your left leg as a pivot point, lower your upper body forward while simultaneously lifting up your left leg'),
  (37, 7, 'At this point, your raised (left) leg, upper body and arms should all form a line that is perfectly parallel to the floor'),
  (38, 7, 'Begin to stretch your body in two opposite directions – pull back with your lifted leg, and push forward with your torso and arms'),
  (39, 8, 'Stand straight, with both feet as close together as possible'),
  (40, 8, 'Raise both your arms above your head and towards the ceiling while keeping the inside of your palms facing each other'),
  (41, 8, 'Take a step (4 feet or more) to your right (wider stance = easier stretch)'),
  (42, 8, 'spread both your arms sideways so that they become parallel to the floor – just like if you were pretending to be an airplane'),
  (43, 8, 'While keeping your knees locked, move your hips slightly backwards while arching your lower back a little; you should feel a natural curve forming right above your buttocks. You’ll know you are doing this properly if you feel a slight stretch in the hamstrings'),
  (44, 8, 'Begin to slowly lower your torso, as if you were attempting to bring it between your legs. While descending, make sure to keep your head, neck and spine in one straight line (do not tuck your chin or bend the head backwards)'),
  (45, 8, 'The goal is to get your torso so low that it becomes nearly perpendicular to the floor. Once you have brought the torso as low as you can, use both your hands to grab your heals from beneath (not from the back), and then attempt to pull the heals upwards with your strength, providing for an excellent whole-body stretch'),
  (46, 9, 'Stand tall with both feet together, and raise both your arms above your head while keeping your palms together'),
  (47, 9, 'Take a big, side-way step with right leg (5-6 feet) and extend your arms parallel to the floor'),
  (48, 9, 'Turn your right foot by a little over 90 degrees'),
  (49, 9, 'Bend your right leg at the knee far enough for that knee to be right over you ankle'),
  (50, 9, 'Up until now, your arms were constantly parallel to the floor. Now is the point you will slightly twist your body in the direction of your right leg'),
  (51, 9, 'Use the right arm to push back the right knee to feel a solid stretch in the hips and upper leg'),
  (52, 9, 'Left arm should pull upwards, while the right arm should pull downwards'),
  (53, 10, 'Bring feet together and raise arms above head'),
  (54, 10, 'Form steeple grip with hands and move right leg 4 feet toward right'),
  (55, 10, 'Turn right foot out 90 degrees and do same with torso, hips, arms, and head'),
  (56, 10, 'Rotate left foot in about 45 degrees to keep hips squared forward'),
  (57, 10, 'Tuck chin into chest and maintain straightened arms and legs'),
  (58, 10, 'Round down from hips until forehead touches right knee'),
  (59, 10, 'Engage abdominal muscles, round spine by lifting belly, and straighten right leg'),
  (60, 11, 'Balance on left leg'),
  (61, 11, 'Use right hand to hold right foot up in front of left upper thigh'),
  (62, 11, 'Keep sole of right foot facing toward ceiling'),
  (63, 11, 'Tighten buttocks and straighten spine'),
  (64, 11, 'Tailbone is lengthening down'),
  (65, 11, 'Ribs are drawn in'),
  (66, 11, 'Shoulders are moving back rather than rounding forward'),
  (67, 11, 'Open right hip and work right knee down and back until knees are in 1 line'),
  (68, 11, 'If right foot remains above left thigh, bring hands into prayer in front of chest'),
  (69, 11, 'Prevent right foot from slipping by pushing hips forward and bringing right knee back'),
  (70, 12, 'Begin in Tree pose and then hinge forward from hips while keeping standing leg straight'),
  (71, 12, 'Distribute weight evenly through thighs, calves, and all areas of standing foot before descending'),
  (72, 12, 'Reach for floor and transfer body weight to hands so that knees are protected as standing leg starts to bend'),
  (73, 12, 'Once you’re sitting on heel, walk hands back by hips, lift chest, and straighten spine'),
  (74, 12, 'Maintain balance by visually focusing on floor about 2 feet away and by using core strength to straighten spine'),
  (75, 12, 'Bring hands into prayer'),
  (76, 13, 'Lie back on floor, touch heels together, and let feet fall sideways'),
  (77, 13, 'Relax arms by letting them gently fall to both sides with palms facing up'),
  (78, 13, 'Pull shoulders down and back flatly against floor'),
  (79, 13, 'Breathe slowly and deeply, encouraging more tension to leave body with each exhale'),
  (80, 13, 'Focus on breathing, especially if mind wanders'),
  (81, 14, 'Take hold of right leg 2 inches below knee and draw right knee out and down toward chest'),
  (82, 14, 'Keep elbows in close to body and relax shoulders flatly on floor'),
  (83, 14, 'Tuck chin into chest and keep left leg firmly on floor; if left calf muscle lifts, flex foot'),
  (84, 14, 'Repeat on other side'),
  (85, 14, 'Raise knees toward chest and grab onto opposite elbows, hooking arms just under knees'),
  (86, 14, 'Tuck chin to chest to lengthen neck; Flatten shoulders against ground to extend upper spine; Push hips and tailbone down to work lower spine'),
  (87, 14, 'Work toward getting every vertebra of spine on floor'),
  (88, 15, 'Start from Corpse pose'),
  (89, 15, 'Flex toes up toward ceiling'),
  (90, 15, 'Bring both arms overhead and cross thumbs'),
  (91, 15, 'Inhale as you sit up and exhale as you start diving forward to reach for toes'),
  (92, 15, 'Work toward keeping legs on floor'),
  (93, 15, 'Grab toes and lay body flat on legs to stretch back of body'),
  (94, 16, 'Grab toes and lay body flat on legs to stretch back of body'),
  (95, 16, 'Lie on belly'),
  (96, 16, 'Put palms flatly on floor directly underneath shoulders, fingertips in line with tops of shoulders'),
  (97, 16, 'Keep legs and feet together and keep them stretched down and back'),
  (98, 16, 'Draw shoulders down and keep elbows in close to ribs'),
  (99, 16, 'Inhale, look up to ceiling, and arch head and torso back until belly button just touches floor (it’s not a push up)'),
  (100, 16, 'Ensure that arms are “L-shaped” at 90 degrees'),
  (101, 17, 'Single Leg:'),
  (102, 17, 'Lie on belly with chin forward on towel'),
  (103, 17, 'Move arms underneath body (palms down) by lifting one hip at a time and rolling to one side'),
  (104, 17, 'Without lifting hips, raise right leg straight up to 45-degrees, and keep left leg relaxed on floor'),
  (105, 17, 'Maintain tightened muscles in right leg, point toes, and lock knee'),
  (106, 17, 'Repeat other leg'),
  (107, 17, 'Both legs:'),
  (108, 17, 'Protect neck by tilting head down, tucking chin in, and keeping mouth on towel'),
  (109, 17, 'Lift legs up away from floor, breathe through nose, and hold pose for 10 seconds'),
  (110, 17, 'Strive to lift legs and hips away from floor all the way to belly button'),
  (111, 18, 'Begin by targeting mid-spine'),
  (112, 18, 'Lay belly down on floor'),
  (113, 18, 'Turn chin in and stretch arms out to sides in line with shoulders, palms down'),
  (114, 18, 'Keep legs, knees, and feet together making sure that calves, thighs, and buttocks remain tightened throughout pose'),
  (115, 18, 'Exhale completely, then inhale'),
  (116, 18, 'Lift arms, legs, chest, head, and torso away from floor'),
  (117, 18, 'Remember to breathe; a deep inhale will help you lift'),
  (118, 18, 'To arch body more: Use back muscles, and maintain straightened arms and legs and keep them engaged. You should also use core strength'),
  (119, 18, 'Set goal to eventually balance body on abdomen'),
  (120, 19, 'Lie on belly, bend knees, reach back, and grab outside of each foot 2 inches below toes'),
  (121, 19, 'Keep feet and knees together as close as possible'),
  (122, 19, 'Inhale deeply and simultaneously kick back into hands and lift thighs and upper body away from floor'),
  (123, 19, 'For more power, push hips and pelvis into floor before lifting legs up and back'),
  (124, 19, 'Release shoulders back as you lift torso'),
  (125, 19, 'Roll body weight forward to balance on middle of belly'),
  (126, 19, 'Flex or point toes toward mirror, not ceiling'),
  (127, 19, 'Work toward these goals: Relax neck and drop head back as much as possible; Look for toes and use equal strength in both legs to kick'),
  (128, 20, 'Start by sitting between heels with feet facing up and knees together'),
  (129, 20, 'If knees feel sharp pain, separate them a bit, but ensure that feet are hugging sides of hips'),
  (130, 20, 'Place hands on soles of feet with fingers facing forward'),
  (131, 20, 'Lower back 1 elbow at a time, and then look back and let top of head drop back'),
  (132, 20, 'Slowly put shoulders down onto floor as you slide elbows out'),
  (133, 20, 'Raise arms overhead and latch onto opposite elbows'),
  (134, 20, 'Push arms and shoulders down and then bring them flat against floor'),
  (135, 20, 'Tuck chin into chest, press back with arms, and lift ribs up to feel chest stretch'),
  (136, 20, 'Simultaneously ground knees and feel the stretch along stomach, hip flexors, front thighs and knees'),
  (137, 21, 'Enter kneeling position: sit on heels with feet and knees together'),
  (138, 21, 'Raise arms above head and bring palms together with thumbs crossed'),
  (139, 21, 'Maintain straightened arms and spine throughout pose'),
  (140, 21, 'Inhale while stretching up'),
  (141, 21, 'Stretch forward all the way until forehead and sides of hands touch floor'),
  (142, 21, 'Engage arms and straighten elbows so that wrists, elbows, and triceps lift away from floor'),
  (143, 21, 'Keep sliding fingertips forward'),
  (144, 21, 'To deeply stretch spine, do these simultaneously: Reach buttocks back to heels; Keep using abdominal muscles (Eventually, buttocks will touch heels throughout pose)'),
  (145, 22, 'Start with knees on floor and maintain 6 inches of space between knees and feet'),
  (146, 22, 'Support spine by placing hands on back of hips with fingers pointing down'),
  (147, 22, 'Inhale while lifting chest, and exhale while dropping head back'),
  (148, 22, 'Keep chest lifted throughout pose to minimize compression in lower back'),
  (149, 22, 'Bring right hand down to grab right heel and left hand down to grab left heel; Put thumbs on outside of feet and place fingers on soles'),
  (150, 22, 'Keep arching spine back and work hips forward while lengthening tailbone down toward floor'),
  (151, 22, 'Continue lifting chest to ensure that body weight hasn’t sunk back into heels and hands'),
  (152, 23, 'Kneel on a towel that extends back past toes'),
  (153, 23, 'Reach back and fold edges of towel over heels'),
  (154, 23, 'Grab heels and towel together'),
  (155, 23, 'Maintain firm grip with thumbs outside feet and with fingers on soles'),
  (156, 23, 'Keep chin tucked into chest'),
  (157, 23, 'While exhaling, begin curling torso slowly and tightly forward and inward until forehead touches knees and top of head touches floor'),
  (158, 23, 'If you notice a gap between forehead and knees, walk knees forward to meet forehead'),
  (159, 23, 'As you curl inward, lift hips into air, firmly pull on heels, and roll body forward like wheel'),
  (160, 23, 'Push feet firmly into floor and pull on heels with all your power to maintain about 25% of body weight on head'),
  (161, 23, 'Work toward these goals: Completely straighten arms; Reach upward using hips so that thighs are perpendicular to floor'),
  (162, 24, 'Extend right leg out 45 degrees; Bend left leg until left sole pushes against right inner thigh; Bring left heel up to crotch (Legs form 90 degree angle)'),
  (163, 24, 'Inhale, raise arms overhead, twist toward right, and stretch down over right leg'),
  (164, 24, 'Hold right foot with hands tightly interlaced; bend right knee if needed'),
  (165, 24, 'Tuck chin into chest and round your back until forehead touches right knee'),
  (166, 24, 'If needed, bend right knee to touch forehead to knee'),
  (167, 24, 'Begin bending elbows straight down toward floor'),
  (168, 24, 'Keep spine evenly aligned over right leg by rolling left shoulder and elbow down farther'),
  (169, 25, 'Set up for pose by doing these: Bend left leg on floor until left heel meets side of right buttock; Bend right knee to bring right leg up and over left leg; Line right heel up to touch left knee'),
  (170, 25, 'Ensure that left knee and both buttocks stay on floor throughout pose'),
  (171, 25, 'Line right hand up behind back near tailbone to keep body weight forward and lifted throughout pose'),
  (172, 25, 'Deepen twist by doing these: Press left elbow into right knee; Reach right hand behind your back all the way around to hold left thigh or hip'),
  (173, 25, 'As you twist, think of lifting up'),
  (174, 25, 'Lift abdomen out of pelvis, and lift upper body up toward ceiling'),
  (175, 25, 'Work shoulders down and away from ears'),
  (176, 26, 'Do not underestimate this pose; focus on it as you would on any other pose'),
  (177, 26, 'Keep your body firm and do not move anything at all except for your stomach'),
  (178, 26, 'At the same time, make sure that your belly is relaxed and not tensed'),
  (179, 26, 'During the second set of this pose, increase your breathing speed');
SET IDENTITY_INSERT [Instruction] OFF


SET IDENTITY_INSERT [Note] ON
INSERT INTO [Note]
  ([Id], [PoseId], [UserProfileId], [Content], [CreateDateTime])
VALUES
  (1, 1, 1, 'I love this breathing exercise.', '2020-07-31 20:30:30'),
  (2, 1, 1, 'Its hard to get my elbows to touch.', '2020-07-27 01:30:30'),
  (3, 1, 1, 'This exercise warms me up perfectly.', '2020-07-30 20:00:30'),
  (4, 1, 1, 'Gets me seating!', '2020-07-31 10:30:30');
SET IDENTITY_INSERT [Note] OFF

SET IDENTITY_INSERT [Comment] ON
INSERT INTO [Comment]
  ([Id], [PoseId], [UserProfileId], [Content], [CreateDateTime])
VALUES
  (1, 1, 8, 'Does anybody else struggle to get there elbows up very high? I just feel so awkward doing this one.', '2020-006-06 20:30:30'),
  (2, 1, 1, 'Totally! Its not as easy as it looks.', '2020-07-27 01:30:30'),
  (3, 1, 5, 'I love this!.', '2020-07-30 20:00:30'),
  (4, 2, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (5, 2, 6, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (6, 2, 3, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (7, 2, 8, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (8, 3, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (9, 3, 5, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (10, 3, 8, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (11, 4, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (12, 10, 10, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (13, 11, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (14, 12, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (15, 13, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (16, 14, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (17, 15, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (18, 16, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (19, 17, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (20, 18, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (21, 19, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (22, 20, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (23, 21, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (24, 22, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (25, 23, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (26, 24, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (27, 25, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (28, 26, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (29, 5, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (30, 6, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (31, 7, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (32, 8, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (33, 9, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (34, 17, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (35, 17, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (36, 17, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (37, 17, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (38, 17, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (39, 17, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (40, 17, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (41, 17, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (42, 17, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (43, 17, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (44, 17, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (45, 17, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (46, 17, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (47, 17, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (48, 17, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (49, 17, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (50, 17, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (51, 17, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (52, 17, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (53, 17, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (54, 17, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (55, 17, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (56, 17, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (57, 17, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (58, 17, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (59, 17, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (60, 17, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (61, 17, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (62, 17, 1, 'This is just starter comment data...', '2020-07-31 10:30:30'),
  (63, 17, 1, 'This is just starter comment data...', '2020-07-31 10:30:30');
SET IDENTITY_INSERT [Comment] OFF
