BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "schema_migrations" (
	"version"	varchar NOT NULL,
	PRIMARY KEY("version")
);
CREATE TABLE IF NOT EXISTS "ar_internal_metadata" (
	"key"	varchar NOT NULL,
	"value"	varchar,
	"created_at"	datetime(6) NOT NULL,
	"updated_at"	datetime(6) NOT NULL,
	PRIMARY KEY("key")
);
CREATE TABLE IF NOT EXISTS "users" (
	"id"	integer NOT NULL,
	"first_name"	varchar,
	"last_name"	varchar,
	"username"	varchar,
	"email"	varchar NOT NULL DEFAULT '',
	"encrypted_password"	varchar NOT NULL DEFAULT '',
	"reset_password_token"	varchar,
	"reset_password_sent_at"	datetime,
	"remember_created_at"	datetime,
	"created_at"	datetime(6) NOT NULL,
	"updated_at"	datetime(6) NOT NULL,
	"provider"	varchar,
	"uid"	varchar,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "beds" (
	"id"	integer NOT NULL,
	"name"	varchar,
	"location"	varchar,
	"size"	integer,
	"medium"	varchar,
	"created_at"	datetime(6) NOT NULL,
	"updated_at"	datetime(6) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "plants" (
	"id"	integer NOT NULL,
	"germination_date"	date,
	"transplant_date"	date,
	"nickname"	varchar,
	"variety"	varchar,
	"species"	varchar,
	"description"	text,
	"user_id"	integer,
	"bed_id"	integer,
	"created_at"	datetime(6) NOT NULL,
	"updated_at"	datetime(6) NOT NULL,
	"harvested"	boolean NOT NULL DEFAULT 0,
	PRIMARY KEY("id" AUTOINCREMENT),
	CONSTRAINT "fk_rails_1b909aa33d" FOREIGN KEY("bed_id") REFERENCES "beds"("id"),
	CONSTRAINT "fk_rails_05ea0b909d" FOREIGN KEY("user_id") REFERENCES "users"("id")
);
CREATE TABLE IF NOT EXISTS "harvests" (
	"id"	integer NOT NULL,
	"weight"	float,
	"harvest_date"	date,
	"plant_id"	integer,
	"created_at"	datetime(6) NOT NULL,
	"updated_at"	datetime(6) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	CONSTRAINT "fk_rails_3dc75df67e" FOREIGN KEY("plant_id") REFERENCES "plants"("id")
);
INSERT INTO "schema_migrations" VALUES ('20200614225204');
INSERT INTO "schema_migrations" VALUES ('20200615143607');
INSERT INTO "schema_migrations" VALUES ('20200615193822');
INSERT INTO "schema_migrations" VALUES ('20200615203537');
INSERT INTO "schema_migrations" VALUES ('20200617195625');
INSERT INTO "schema_migrations" VALUES ('20200618132950');
INSERT INTO "ar_internal_metadata" VALUES ('environment','development','2020-06-30 16:55:12.550907','2020-06-30 16:55:12.550907');
INSERT INTO "users" VALUES (1,NULL,NULL,NULL,'heather@heather.com','$2a$12$jVp/.iMRDV4jlZ6WvYnvquS33ohOFh1futjjaepuWfinc0brcQkfm',NULL,NULL,NULL,'2020-06-30 17:12:22.281767','2020-06-30 17:12:22.281767',NULL,NULL);
INSERT INTO "users" VALUES (2,NULL,NULL,'Trevor Tarpinian','tmtarpinian@gmail.com','$2a$12$01Qjoe90WLAZgorIOgwg2.OR3EVCUqlSZBEDfV65PVDJ1t13iGVoK',NULL,NULL,NULL,'2020-06-30 17:22:40.572985','2020-06-30 17:22:40.572985','github','58449380');
INSERT INTO "beds" VALUES (1,'House (Southeast)','South wall of house (easternmost)',4,'Soil','2020-06-30 17:16:31.933574','2020-06-30 17:20:24.712038');
INSERT INTO "beds" VALUES (2,'1020 A','Basement',2,'Soil','2020-06-30 17:23:55.164174','2020-07-09 02:58:11.886405');
INSERT INTO "beds" VALUES (3,'1020 B','Basement',NULL,'Soil','2020-06-30 17:30:48.809089','2020-07-09 19:47:53.596803');
INSERT INTO "beds" VALUES (4,'1020 C','Basement',2,'Soil','2020-06-30 17:32:22.526081','2020-07-09 19:48:05.919396');
INSERT INTO "beds" VALUES (5,'AeroGarden','Basement',1,'Hydroponic','2020-06-30 17:34:32.125603','2020-07-01 14:00:02.743894');
INSERT INTO "beds" VALUES (6,'1020 Tray 062920d','Basement',2,'Soil','2020-07-01 13:33:29.348646','2020-07-01 13:57:59.637533');
INSERT INTO "beds" VALUES (7,'House (South)','South wall of house (center)',4,'Soil','2020-07-01 13:54:30.551848','2020-07-01 13:55:21.267923');
INSERT INTO "beds" VALUES (8,'House (Southwest)','South wall of house (westernmost)',4,'Soil','2020-07-01 14:12:08.856886','2020-07-01 14:12:08.856886');
INSERT INTO "beds" VALUES (9,'Raised Bed','Driveway',30,'Soil','2020-07-01 14:15:52.374054','2020-07-01 14:15:52.374054');
INSERT INTO "beds" VALUES (10,'Aquaponic (37 Gallon)','Basement',4,'Hydroponic','2020-11-17 18:46:12.526039','2020-11-17 18:46:12.526039');
INSERT INTO "plants" VALUES (1,'2020-02-20','2020-05-16','','Sweet Basil','Ocimum basilicum ''Licorice''','',1,1,'2020-06-30 17:16:31.955722','2020-06-30 17:16:40.168114',1);
INSERT INTO "plants" VALUES (2,NULL,'2020-06-29','','Salad Mix Microgreens','','',2,2,'2020-06-30 17:23:55.172719','2020-07-09 19:47:42.153161',1);
INSERT INTO "plants" VALUES (3,NULL,'2020-06-29','','Salad Mix Microgreens','','',2,3,'2020-06-30 17:30:48.816656','2020-07-09 19:51:03.928892',1);
INSERT INTO "plants" VALUES (4,NULL,'2020-06-29','','Salad Mix Microgreens','','',2,4,'2020-06-30 17:32:22.533574','2020-07-09 20:00:39.273565',1);
INSERT INTO "plants" VALUES (5,'2020-03-16','2020-04-11','','Cherry Tomato','Solanum lycopersicum','Grown from Betty seeds',2,5,'2020-06-30 17:34:32.150168','2020-07-01 14:02:34.034756',0);
INSERT INTO "plants" VALUES (6,NULL,'2020-06-29','','Scotts Turf Build Grass Seed','','19.18% Perennial Ryegrass
11.98% Marshall Annual Ryegrass
7.19% Oracle Creeping Red Fescue
2.4% Gaelic Kentucky Bluegrass
2.39% Abbey Kentucky Bluegrass
4.81% Compass Chewings Fescue',2,6,'2020-07-01 13:33:29.364778','2020-07-01 13:42:11.098657',0);
INSERT INTO "plants" VALUES (7,'2020-04-11','2020-05-16','Left','Broccoli','Brassica oleracea (Italica)','',1,7,'2020-07-01 13:54:30.563937','2020-07-10 13:34:43.524060',1);
INSERT INTO "plants" VALUES (8,'2020-03-16','2020-04-11','','Cherry Tomato','Solanum lycopersicum','grown from Betty seeds',2,5,'2020-07-01 14:03:24.791367','2020-07-01 14:03:24.791367',0);
INSERT INTO "plants" VALUES (9,NULL,NULL,'','Tomato','','',1,1,'2020-07-01 14:08:48.906764','2020-07-01 14:08:48.906764',0);
INSERT INTO "plants" VALUES (10,NULL,NULL,'','Tomato','','',1,1,'2020-07-01 14:09:10.097017','2020-07-01 14:09:10.097017',0);
INSERT INTO "plants" VALUES (11,NULL,NULL,'','Bell Pepper','','',1,1,'2020-07-01 14:09:23.988909','2020-07-01 14:09:23.988909',0);
INSERT INTO "plants" VALUES (12,NULL,NULL,'','Detroit Red Beets','','',1,1,'2020-07-01 14:09:37.186265','2020-07-01 14:09:37.186265',0);
INSERT INTO "plants" VALUES (13,NULL,NULL,'','Detroit Red Beets','','',1,1,'2020-07-01 14:09:59.102663','2020-07-01 14:09:59.102663',0);
INSERT INTO "plants" VALUES (14,NULL,NULL,'Center','Broccoli','','',1,7,'2020-07-01 14:10:20.140770','2020-07-10 13:34:10.435529',1);
INSERT INTO "plants" VALUES (15,NULL,NULL,'Right','Broccoli','','',1,7,'2020-07-01 14:10:32.013339','2020-07-10 13:33:24.962291',1);
INSERT INTO "plants" VALUES (16,NULL,NULL,'','Detroit Red Beets','','',1,7,'2020-07-01 14:10:57.834058','2020-07-01 14:10:57.834058',0);
INSERT INTO "plants" VALUES (17,NULL,NULL,'','Detroit Red Beets','','',1,7,'2020-07-01 14:11:09.814661','2020-07-01 14:11:09.814661',0);
INSERT INTO "plants" VALUES (18,NULL,NULL,'','Green Onion','','',1,7,'2020-07-01 14:11:23.144547','2020-07-01 14:11:23.144547',0);
INSERT INTO "plants" VALUES (19,NULL,NULL,'','Nasturtium','','',1,7,'2020-07-01 14:11:38.527367','2020-07-01 14:11:38.527367',0);
INSERT INTO "plants" VALUES (20,NULL,NULL,'East (Right Facing)','Tomato','','',1,8,'2020-07-01 14:12:08.860314','2020-07-04 02:19:39.016866',1);
INSERT INTO "plants" VALUES (21,NULL,NULL,'East (Left Facing)','Tomato','','',1,8,'2020-07-01 14:12:32.875145','2020-07-08 16:17:30.863519',1);
INSERT INTO "plants" VALUES (22,NULL,NULL,'','Italian Parsely','','',1,8,'2020-07-01 14:12:49.227370','2020-07-01 14:12:49.227370',0);
INSERT INTO "plants" VALUES (23,NULL,NULL,'','Broccoli','','Died from caterpillars',1,8,'2020-07-01 14:13:09.492333','2020-07-01 14:13:09.492333',0);
INSERT INTO "plants" VALUES (24,NULL,NULL,'','Curly Parsley','','',1,8,'2020-07-01 14:13:33.780151','2020-07-01 14:13:33.780151',0);
INSERT INTO "plants" VALUES (25,NULL,NULL,'','Bell Pepper','','',1,8,'2020-07-01 14:13:49.740199','2020-07-01 14:13:49.740199',0);
INSERT INTO "plants" VALUES (26,NULL,'2020-05-16','Tomato 1','Tomato','','',1,9,'2020-07-01 14:15:52.383717','2020-07-09 19:33:25.161708',1);
INSERT INTO "plants" VALUES (27,NULL,NULL,'','Nasturtium','','',1,9,'2020-07-01 14:16:11.572763','2020-07-01 14:16:11.572763',0);
INSERT INTO "plants" VALUES (28,NULL,NULL,'','Nasturtium','','',1,9,'2020-07-01 14:16:21.582139','2020-07-01 14:16:21.582139',0);
INSERT INTO "plants" VALUES (29,NULL,NULL,'','Nasturtium','','',1,9,'2020-07-01 14:16:29.918030','2020-07-01 14:16:29.918030',0);
INSERT INTO "plants" VALUES (30,NULL,NULL,'','Tomato','','',1,9,'2020-07-01 14:17:03.443101','2020-07-01 14:17:03.443101',0);
INSERT INTO "plants" VALUES (31,NULL,NULL,'','Tomato','','',1,9,'2020-07-01 14:17:17.766681','2020-07-01 14:17:17.766681',0);
INSERT INTO "plants" VALUES (32,NULL,NULL,'','Tomato','','',1,9,'2020-07-01 14:17:26.969032','2020-07-01 14:17:26.969032',0);
INSERT INTO "plants" VALUES (33,NULL,NULL,'','Tomato','','',1,9,'2020-07-01 14:17:42.872019','2020-07-01 14:17:42.872019',0);
INSERT INTO "plants" VALUES (34,NULL,NULL,'','Tomato','','',1,9,'2020-07-01 14:17:57.014692','2020-07-01 14:17:57.014692',0);
INSERT INTO "plants" VALUES (35,NULL,NULL,'','Tomato','','',1,9,'2020-07-01 14:18:16.878025','2020-07-01 14:18:16.878025',0);
INSERT INTO "plants" VALUES (36,NULL,NULL,'','Tomato','','',1,9,'2020-07-01 14:18:29.343447','2020-07-01 14:18:29.343447',0);
INSERT INTO "plants" VALUES (37,'2020-03-16','2020-05-16','Cilantro 1','Cilantro','','',1,9,'2020-07-01 14:19:49.482036','2020-07-01 14:25:21.196966',1);
INSERT INTO "plants" VALUES (38,NULL,NULL,'','Cilantro','','',1,9,'2020-07-01 14:20:00.753061','2020-07-01 14:20:00.753061',0);
INSERT INTO "plants" VALUES (39,NULL,NULL,'','Sweet Basil','','',1,9,'2020-07-01 14:20:18.977480','2020-07-01 14:20:18.977480',0);
INSERT INTO "plants" VALUES (40,NULL,NULL,'','Bell Pepper','','',1,9,'2020-07-01 14:20:44.993893','2020-07-01 14:20:44.993893',0);
INSERT INTO "plants" VALUES (41,NULL,NULL,'','Bell Pepper','','',1,9,'2020-07-01 14:20:52.885518','2020-07-01 14:20:52.885518',0);
INSERT INTO "plants" VALUES (42,NULL,NULL,'','Bell Pepper','','',1,9,'2020-07-01 14:21:01.048379','2020-07-01 14:21:01.048379',0);
INSERT INTO "plants" VALUES (43,NULL,NULL,'','Bell Pepper','','',1,9,'2020-07-01 14:21:08.624866','2020-07-01 14:21:08.624866',0);
INSERT INTO "plants" VALUES (44,NULL,NULL,'','Broccoli','','',1,9,'2020-07-01 14:21:22.066026','2020-07-01 14:21:22.066026',0);
INSERT INTO "plants" VALUES (45,NULL,NULL,'','Broccoli','','',1,9,'2020-07-01 14:21:30.432115','2020-07-01 14:21:30.432115',0);
INSERT INTO "plants" VALUES (46,NULL,NULL,NULL,'Tomato',NULL,NULL,2,10,'2020-11-17 18:46:12.546498','2020-11-17 18:46:12.546498',0);
INSERT INTO "plants" VALUES (47,NULL,NULL,'','Tomato','','',2,10,'2020-11-17 18:46:29.690648','2020-11-17 18:46:29.690648',0);
INSERT INTO "plants" VALUES (48,NULL,NULL,'','Tomato','','',2,10,'2020-11-17 18:46:40.565542','2020-11-17 18:46:40.565542',0);
INSERT INTO "harvests" VALUES (1,0.2,'2020-06-29',1,'2020-06-30 17:16:40.136570','2020-07-01 15:52:55.572093');
INSERT INTO "harvests" VALUES (2,0.2,'2020-06-29',37,'2020-07-01 14:25:21.167663','2020-07-01 14:33:45.671187');
INSERT INTO "harvests" VALUES (3,0.3,'2020-06-24',37,'2020-07-01 14:25:35.109442','2020-07-01 14:25:55.618461');
INSERT INTO "harvests" VALUES (4,0.8,'2020-06-29',20,'2020-07-01 14:31:20.918134','2020-07-01 14:31:20.918134');
INSERT INTO "harvests" VALUES (8,4.0,'2020-07-03',20,'2020-07-04 02:19:53.229591','2020-07-04 02:19:53.229591');
INSERT INTO "harvests" VALUES (9,3.4,'2020-07-06',20,'2020-07-08 16:16:48.497685','2020-07-08 16:16:48.497685');
INSERT INTO "harvests" VALUES (10,0.6,'2020-07-06',21,'2020-07-08 16:17:30.848260','2020-07-08 16:17:30.848260');
INSERT INTO "harvests" VALUES (11,0.7,'2020-07-09',21,'2020-07-09 19:32:31.210503','2020-07-09 19:32:31.210503');
INSERT INTO "harvests" VALUES (12,0.8,'2020-07-09',26,'2020-07-09 19:33:25.137933','2020-07-09 19:33:25.137933');
INSERT INTO "harvests" VALUES (13,4.7,'2020-07-09',2,'2020-07-09 19:47:42.125598','2020-07-09 19:47:42.125598');
INSERT INTO "harvests" VALUES (14,3.5,'2020-07-09',3,'2020-07-09 19:51:03.903408','2020-07-09 19:51:03.903408');
INSERT INTO "harvests" VALUES (15,5.6,'2020-07-09',4,'2020-07-09 20:00:39.251569','2020-07-09 20:00:39.251569');
INSERT INTO "harvests" VALUES (16,7.6,'2020-07-10',15,'2020-07-10 13:33:24.923638','2020-07-10 13:33:24.923638');
INSERT INTO "harvests" VALUES (17,8.1,'2020-07-10',14,'2020-07-10 13:34:10.412492','2020-07-10 13:34:10.412492');
INSERT INTO "harvests" VALUES (18,4.8,'2020-07-10',7,'2020-07-10 13:34:43.504372','2020-07-10 13:34:43.504372');
CREATE UNIQUE INDEX IF NOT EXISTS "index_users_on_email" ON "users" (
	"email"
);
CREATE UNIQUE INDEX IF NOT EXISTS "index_users_on_reset_password_token" ON "users" (
	"reset_password_token"
);
CREATE INDEX IF NOT EXISTS "index_plants_on_user_id" ON "plants" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "index_plants_on_bed_id" ON "plants" (
	"bed_id"
);
CREATE INDEX IF NOT EXISTS "index_harvests_on_plant_id" ON "harvests" (
	"plant_id"
);
COMMIT;
