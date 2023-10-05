BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "django_migrations" (
	"id"	integer NOT NULL,
	"app"	varchar(255) NOT NULL,
	"name"	varchar(255) NOT NULL,
	"applied"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_content_type" (
	"id"	integer NOT NULL,
	"app_label"	varchar(100) NOT NULL,
	"model"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_group_permissions" (
	"id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_permission" (
	"id"	integer NOT NULL,
	"content_type_id"	integer NOT NULL,
	"codename"	varchar(100) NOT NULL,
	"name"	varchar(255) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_group" (
	"id"	integer NOT NULL,
	"name"	varchar(150) NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "cuentas_usuario" (
	"id"	integer NOT NULL,
	"password"	varchar(128) NOT NULL,
	"last_login"	datetime,
	"is_superuser"	bool NOT NULL,
	"username"	varchar(30) NOT NULL UNIQUE,
	"first_name"	varchar(150) NOT NULL,
	"last_name"	varchar(150) NOT NULL,
	"email"	varchar(254) NOT NULL UNIQUE,
	"is_staff"	bool NOT NULL,
	"is_active"	bool NOT NULL,
	"date_joined"	datetime NOT NULL,
	"sexo"	varchar(9) NOT NULL,
	"telefono"	varchar(9) NOT NULL,
	"rut"	varchar(10) NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "cuentas_usuario_groups" (
	"id"	integer NOT NULL,
	"usuario_id"	bigint NOT NULL,
	"group_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("usuario_id") REFERENCES "cuentas_usuario"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "cuentas_usuario_user_permissions" (
	"id"	integer NOT NULL,
	"usuario_id"	bigint NOT NULL,
	"permission_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("usuario_id") REFERENCES "cuentas_usuario"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_admin_log" (
	"id"	integer NOT NULL,
	"object_id"	text,
	"object_repr"	varchar(200) NOT NULL,
	"action_flag"	smallint unsigned NOT NULL CHECK("action_flag" >= 0),
	"change_message"	text NOT NULL,
	"content_type_id"	integer,
	"user_id"	bigint NOT NULL,
	"action_time"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "cuentas_usuario"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "barberos_horario" (
	"id"	integer NOT NULL,
	"desde"	time NOT NULL,
	"hasta"	time NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "barberos_servicio" (
	"id"	integer NOT NULL,
	"nombre"	varchar(200) NOT NULL UNIQUE,
	"precio"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "barberos_barbero" (
	"id"	integer NOT NULL,
	"nombre"	varchar(200) NOT NULL,
	"rut"	varchar(15) NOT NULL,
	"email"	varchar(254) NOT NULL,
	"telefono"	varchar(17) NOT NULL,
	"servicio_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("servicio_id") REFERENCES "barberos_servicio"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "reservas_reserva" (
	"id"	integer NOT NULL,
	"dia"	date NOT NULL,
	"barbero_id"	bigint NOT NULL,
	"horario_id"	bigint NOT NULL,
	"usuario_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("usuario_id") REFERENCES "cuentas_usuario"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("horario_id") REFERENCES "barberos_horario"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("barbero_id") REFERENCES "barberos_barbero"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_session" (
	"session_key"	varchar(40) NOT NULL,
	"session_data"	text NOT NULL,
	"expire_date"	datetime NOT NULL,
	PRIMARY KEY("session_key")
);
INSERT INTO "django_migrations" VALUES (1,'contenttypes','0001_initial','2022-12-13 20:42:52.552891');
INSERT INTO "django_migrations" VALUES (2,'contenttypes','0002_remove_content_type_name','2022-12-13 20:42:52.569895');
INSERT INTO "django_migrations" VALUES (3,'auth','0001_initial','2022-12-13 20:42:52.592900');
INSERT INTO "django_migrations" VALUES (4,'auth','0002_alter_permission_name_max_length','2022-12-13 20:42:52.608903');
INSERT INTO "django_migrations" VALUES (5,'auth','0003_alter_user_email_max_length','2022-12-13 20:42:52.618906');
INSERT INTO "django_migrations" VALUES (6,'auth','0004_alter_user_username_opts','2022-12-13 20:42:52.630908');
INSERT INTO "django_migrations" VALUES (7,'auth','0005_alter_user_last_login_null','2022-12-13 20:42:52.642911');
INSERT INTO "django_migrations" VALUES (8,'auth','0006_require_contenttypes_0002','2022-12-13 20:42:52.649913');
INSERT INTO "django_migrations" VALUES (9,'auth','0007_alter_validators_add_error_messages','2022-12-13 20:42:52.660915');
INSERT INTO "django_migrations" VALUES (10,'auth','0008_alter_user_username_max_length','2022-12-13 20:42:52.673918');
INSERT INTO "django_migrations" VALUES (11,'auth','0009_alter_user_last_name_max_length','2022-12-13 20:42:52.686921');
INSERT INTO "django_migrations" VALUES (12,'auth','0010_alter_group_name_max_length','2022-12-13 20:42:52.706925');
INSERT INTO "django_migrations" VALUES (13,'auth','0011_update_proxy_permissions','2022-12-13 20:42:52.718928');
INSERT INTO "django_migrations" VALUES (14,'auth','0012_alter_user_first_name_max_length','2022-12-13 20:42:52.731931');
INSERT INTO "django_migrations" VALUES (15,'cuentas','0001_initial','2022-12-13 20:42:52.760937');
INSERT INTO "django_migrations" VALUES (16,'admin','0001_initial','2022-12-13 20:42:52.790944');
INSERT INTO "django_migrations" VALUES (17,'admin','0002_logentry_remove_auto_add','2022-12-13 20:42:52.811949');
INSERT INTO "django_migrations" VALUES (18,'admin','0003_logentry_add_action_flag_choices','2022-12-13 20:42:52.826952');
INSERT INTO "django_migrations" VALUES (19,'barberos','0001_initial','2022-12-13 20:42:52.844956');
INSERT INTO "django_migrations" VALUES (20,'reservas','0001_initial','2022-12-13 20:42:52.865961');
INSERT INTO "django_migrations" VALUES (21,'sessions','0001_initial','2022-12-13 20:42:52.877964');
INSERT INTO "django_content_type" VALUES (1,'admin','logentry');
INSERT INTO "django_content_type" VALUES (2,'auth','permission');
INSERT INTO "django_content_type" VALUES (3,'auth','group');
INSERT INTO "django_content_type" VALUES (4,'contenttypes','contenttype');
INSERT INTO "django_content_type" VALUES (5,'sessions','session');
INSERT INTO "django_content_type" VALUES (6,'cuentas','usuario');
INSERT INTO "django_content_type" VALUES (7,'reservas','reserva');
INSERT INTO "django_content_type" VALUES (8,'barberos','horario');
INSERT INTO "django_content_type" VALUES (9,'barberos','servicio');
INSERT INTO "django_content_type" VALUES (10,'barberos','barbero');
INSERT INTO "auth_permission" VALUES (1,1,'add_logentry','Can add log entry');
INSERT INTO "auth_permission" VALUES (2,1,'change_logentry','Can change log entry');
INSERT INTO "auth_permission" VALUES (3,1,'delete_logentry','Can delete log entry');
INSERT INTO "auth_permission" VALUES (4,1,'view_logentry','Can view log entry');
INSERT INTO "auth_permission" VALUES (5,2,'add_permission','Can add permission');
INSERT INTO "auth_permission" VALUES (6,2,'change_permission','Can change permission');
INSERT INTO "auth_permission" VALUES (7,2,'delete_permission','Can delete permission');
INSERT INTO "auth_permission" VALUES (8,2,'view_permission','Can view permission');
INSERT INTO "auth_permission" VALUES (9,3,'add_group','Can add group');
INSERT INTO "auth_permission" VALUES (10,3,'change_group','Can change group');
INSERT INTO "auth_permission" VALUES (11,3,'delete_group','Can delete group');
INSERT INTO "auth_permission" VALUES (12,3,'view_group','Can view group');
INSERT INTO "auth_permission" VALUES (13,4,'add_contenttype','Can add content type');
INSERT INTO "auth_permission" VALUES (14,4,'change_contenttype','Can change content type');
INSERT INTO "auth_permission" VALUES (15,4,'delete_contenttype','Can delete content type');
INSERT INTO "auth_permission" VALUES (16,4,'view_contenttype','Can view content type');
INSERT INTO "auth_permission" VALUES (17,5,'add_session','Can add session');
INSERT INTO "auth_permission" VALUES (18,5,'change_session','Can change session');
INSERT INTO "auth_permission" VALUES (19,5,'delete_session','Can delete session');
INSERT INTO "auth_permission" VALUES (20,5,'view_session','Can view session');
INSERT INTO "auth_permission" VALUES (21,6,'add_usuario','Can add Usuario');
INSERT INTO "auth_permission" VALUES (22,6,'change_usuario','Can change Usuario');
INSERT INTO "auth_permission" VALUES (23,6,'delete_usuario','Can delete Usuario');
INSERT INTO "auth_permission" VALUES (24,6,'view_usuario','Can view Usuario');
INSERT INTO "auth_permission" VALUES (25,7,'add_reserva','Can add reserva');
INSERT INTO "auth_permission" VALUES (26,7,'change_reserva','Can change reserva');
INSERT INTO "auth_permission" VALUES (27,7,'delete_reserva','Can delete reserva');
INSERT INTO "auth_permission" VALUES (28,7,'view_reserva','Can view reserva');
INSERT INTO "auth_permission" VALUES (29,8,'add_horario','Can add horario');
INSERT INTO "auth_permission" VALUES (30,8,'change_horario','Can change horario');
INSERT INTO "auth_permission" VALUES (31,8,'delete_horario','Can delete horario');
INSERT INTO "auth_permission" VALUES (32,8,'view_horario','Can view horario');
INSERT INTO "auth_permission" VALUES (33,9,'add_servicio','Can add servicio');
INSERT INTO "auth_permission" VALUES (34,9,'change_servicio','Can change servicio');
INSERT INTO "auth_permission" VALUES (35,9,'delete_servicio','Can delete servicio');
INSERT INTO "auth_permission" VALUES (36,9,'view_servicio','Can view servicio');
INSERT INTO "auth_permission" VALUES (37,10,'add_barbero','Can add barbero');
INSERT INTO "auth_permission" VALUES (38,10,'change_barbero','Can change barbero');
INSERT INTO "auth_permission" VALUES (39,10,'delete_barbero','Can delete barbero');
INSERT INTO "auth_permission" VALUES (40,10,'view_barbero','Can view barbero');
INSERT INTO "cuentas_usuario" VALUES (2,'pbkdf2_sha256$390000$ziKJHDsNUUWNKkiQ7MFz4x$fld0xrsdELPj4yFuvrU75wXXuUyM4+HhQl5jNH+xBp8=','2022-12-14 04:10:13',1,'AdminOp','Administrador','Total','ulloa@gmail.com',1,1,'2022-12-13 20:50:50.394996','MAS','912345671','123456789');
INSERT INTO "cuentas_usuario" VALUES (3,'pbkdf2_sha256$390000$hWaEtOtJMdHJl69ys9xAdT$t1I2nxNczX2kKYf+5vCOFriDRTDi232KtQMbk68pRMs=','2022-12-13 23:20:48.686571',0,'Alexdev','Alban Alexander','Fernández Palma','Alban@gmail.com',0,1,'2022-12-13 23:07:18.128738','MAS','987654123','20224978-7');
INSERT INTO "django_admin_log" VALUES (1,'1','14:00:00 - 13:00:00',2,'[{"changed": {"fields": ["Desde"]}}]',8,2,'2022-12-13 21:06:30.796771');
INSERT INTO "django_admin_log" VALUES (2,'1','Corte regular - 5000',3,'',9,2,'2022-12-13 21:06:42.966717');
INSERT INTO "django_admin_log" VALUES (3,'1','14:00:00 - 13:00:00',3,'',8,2,'2022-12-13 22:52:42.617229');
INSERT INTO "django_admin_log" VALUES (4,'2','09:00:00 - 09:40:00',3,'',8,2,'2022-12-13 22:52:45.650497');
INSERT INTO "django_admin_log" VALUES (5,'3','09:00:00 - 09:40:00',2,'[]',8,2,'2022-12-13 22:53:19.460528');
INSERT INTO "django_admin_log" VALUES (6,'4','09:45:00 - 10:25:00',1,'[{"added": {}}]',8,2,'2022-12-13 22:54:20.343054');
INSERT INTO "django_admin_log" VALUES (7,'5','10:30:00 - 11:10:00',1,'[{"added": {}}]',8,2,'2022-12-13 22:54:32.854328');
INSERT INTO "django_admin_log" VALUES (8,'6','11:15:00 - 11:55:00',1,'[{"added": {}}]',8,2,'2022-12-13 22:55:08.822025');
INSERT INTO "django_admin_log" VALUES (9,'7','12:00:00 - 12:40:00',1,'[{"added": {}}]',8,2,'2022-12-13 22:55:28.165712');
INSERT INTO "django_admin_log" VALUES (10,'8','12:45:00 - 13:25:00',1,'[{"added": {}}]',8,2,'2022-12-13 22:56:03.896410');
INSERT INTO "django_admin_log" VALUES (11,'9','14:30:00 - 15:10:00',1,'[{"added": {}}]',8,2,'2022-12-13 22:56:46.821153');
INSERT INTO "django_admin_log" VALUES (12,'10','15:15:00 - 15:55:00',1,'[{"added": {}}]',8,2,'2022-12-13 22:57:01.978994');
INSERT INTO "django_admin_log" VALUES (13,'11','16:00:00 - 16:40:00',1,'[{"added": {}}]',8,2,'2022-12-13 22:57:57.357294');
INSERT INTO "django_admin_log" VALUES (14,'12','16:40:00 - 16:45:00',1,'[{"added": {}}]',8,2,'2022-12-13 22:58:01.654226');
INSERT INTO "django_admin_log" VALUES (15,'12','16:45:00 - 17:25:00',2,'[{"changed": {"fields": ["Desde", "Hasta"]}}]',8,2,'2022-12-13 23:00:32.802762');
INSERT INTO "django_admin_log" VALUES (16,'13','17:30:00 - 18:15:00',1,'[{"added": {}}]',8,2,'2022-12-13 23:01:12.456415');
INSERT INTO "django_admin_log" VALUES (17,'1','Stearmix',3,'',6,2,'2022-12-13 23:05:07.195680');
INSERT INTO "django_admin_log" VALUES (18,'2','AdminOp',2,'[{"changed": {"fields": ["Usuario"]}}]',6,2,'2022-12-14 03:56:29.857435');
INSERT INTO "django_admin_log" VALUES (19,'2','AdminOp',2,'[{"changed": {"fields": ["Nombre", "Apellido"]}}]',6,2,'2022-12-14 04:11:49.265539');
INSERT INTO "django_admin_log" VALUES (20,'14','17:30:00 - 18:15:00',3,'',8,2,'2022-12-14 04:24:44.021679');
INSERT INTO "barberos_horario" VALUES (3,'09:00:00','09:40:00');
INSERT INTO "barberos_horario" VALUES (4,'09:45:00','10:25:00');
INSERT INTO "barberos_horario" VALUES (5,'10:30:00','11:10:00');
INSERT INTO "barberos_horario" VALUES (6,'11:15:00','11:55:00');
INSERT INTO "barberos_horario" VALUES (7,'12:00:00','12:40:00');
INSERT INTO "barberos_horario" VALUES (8,'12:45:00','13:25:00');
INSERT INTO "barberos_horario" VALUES (9,'14:30:00','15:10:00');
INSERT INTO "barberos_horario" VALUES (10,'15:15:00','15:55:00');
INSERT INTO "barberos_horario" VALUES (11,'16:00:00','16:40:00');
INSERT INTO "barberos_horario" VALUES (12,'16:45:00','17:25:00');
INSERT INTO "barberos_horario" VALUES (13,'17:30:00','18:15:00');
INSERT INTO "barberos_servicio" VALUES (2,'Corte de pelo Classic',6000);
INSERT INTO "barberos_servicio" VALUES (3,'Corte de pelo - Texturizado Faded',10000);
INSERT INTO "barberos_barbero" VALUES (3,'Luis Almonacid|','22755863-6','Luis@gmail.com','987651234',2);
INSERT INTO "reservas_reserva" VALUES (2,'2022-12-15',3,4,3);
INSERT INTO "django_session" VALUES ('3oq41e6ddxxzw3hcjmcfgmhzw39jqbpl','.eJxVjDsOwjAQBe_iGlmRNzgxJT1nsPZnHEC2FCcV4u4kUgpo38y8t4m4LjmuTec4ibkYZ06_GyE_texAHlju1XItyzyR3RV70GZvVfR1Pdy_g4wtbzU5lhHZpyREYwjsB_GscEaXILBuWMFBj6JC0Plu8Kip99gnSABkPl8sDjmC:1p5J5x:KzLxFaMhcuUto48q1_Z2RxbQkAJAqq4707Q3UC8MSVU','2022-12-28 04:10:13.575513');
CREATE UNIQUE INDEX IF NOT EXISTS "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type" (
	"app_label",
	"model"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions" (
	"group_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" (
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" (
	"permission_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission" (
	"content_type_id",
	"codename"
);
CREATE INDEX IF NOT EXISTS "auth_permission_content_type_id_2f476e4b" ON "auth_permission" (
	"content_type_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "cuentas_usuario_groups_usuario_id_group_id_f5ef6c73_uniq" ON "cuentas_usuario_groups" (
	"usuario_id",
	"group_id"
);
CREATE INDEX IF NOT EXISTS "cuentas_usuario_groups_usuario_id_251ff583" ON "cuentas_usuario_groups" (
	"usuario_id"
);
CREATE INDEX IF NOT EXISTS "cuentas_usuario_groups_group_id_e6725cc8" ON "cuentas_usuario_groups" (
	"group_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "cuentas_usuario_user_permissions_usuario_id_permission_id_26c0acea_uniq" ON "cuentas_usuario_user_permissions" (
	"usuario_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "cuentas_usuario_user_permissions_usuario_id_5a9718f1" ON "cuentas_usuario_user_permissions" (
	"usuario_id"
);
CREATE INDEX IF NOT EXISTS "cuentas_usuario_user_permissions_permission_id_1753ad79" ON "cuentas_usuario_user_permissions" (
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_user_id_c564eba6" ON "django_admin_log" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "barberos_barbero_rut_servicio_id_7aa29351_uniq" ON "barberos_barbero" (
	"rut",
	"servicio_id"
);
CREATE INDEX IF NOT EXISTS "barberos_barbero_servicio_id_2864dcb5" ON "barberos_barbero" (
	"servicio_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "reservas_reserva_barbero_id_dia_horario_id_4dce3291_uniq" ON "reservas_reserva" (
	"barbero_id",
	"dia",
	"horario_id"
);
CREATE INDEX IF NOT EXISTS "reservas_reserva_barbero_id_20fe23b5" ON "reservas_reserva" (
	"barbero_id"
);
CREATE INDEX IF NOT EXISTS "reservas_reserva_horario_id_29466197" ON "reservas_reserva" (
	"horario_id"
);
CREATE INDEX IF NOT EXISTS "reservas_reserva_usuario_id_531da18c" ON "reservas_reserva" (
	"usuario_id"
);
CREATE INDEX IF NOT EXISTS "django_session_expire_date_a5c62663" ON "django_session" (
	"expire_date"
);
COMMIT;
