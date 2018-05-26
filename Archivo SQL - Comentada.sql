-- Adminer 4.6.2 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP DATABASE IF EXISTS `utp`;
CREATE DATABASE `utp` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `utp`;

DROP TABLE IF EXISTS `asignaturas`;
CREATE TABLE `asignaturas` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID Asignaturas',
  `programa_id` int(11) NOT NULL COMMENT 'Programa ID Asignaturas',
  `nombre` varchar(255) NOT NULL COMMENT 'Nombre Asignaturas',
  `semestre` int(11) NOT NULL COMMENT 'Semestre Asignaturas',
  `creditos` int(11) NOT NULL COMMENT 'Creditos Asignaturas',
  PRIMARY KEY (`id`),
  KEY `programa_id` (`programa_id`),
  CONSTRAINT `asignaturas_ibfk_1` FOREIGN KEY (`programa_id`) REFERENCES `programa` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Asignaturas';

TRUNCATE `asignaturas`;
INSERT INTO `asignaturas` (`id`, `programa_id`, `nombre`, `semestre`, `creditos`) VALUES
(1,	1,	'Matemáticas 1',	1,	2),
(2,	1,	'Matemáticas 2',	2,	2),
(3,	1,	'Catedra Universitaria',	1,	0),
(4,	1,	'Catedra Cultural',	1,	0);

DROP TABLE IF EXISTS `calendario_academico`;
CREATE TABLE `calendario_academico` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID Calendario Academico',
  `programa_id` int(11) NOT NULL COMMENT 'Programa ID Calendario Academico',
  `actividad` varchar(255) NOT NULL COMMENT 'Actividad Calendario Academico',
  `semestre` int(11) NOT NULL COMMENT 'Semestre Calendario Academico',
  `fecha_inicio` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Fecha Inicio Calendario Academico',
  `fecha_fin` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Fecha Fin Calendario Academico',
  PRIMARY KEY (`id`),
  KEY `programa_id` (`programa_id`),
  CONSTRAINT `calendario_academico_ibfk_1` FOREIGN KEY (`programa_id`) REFERENCES `programa` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Calendario Academico';

TRUNCATE `calendario_academico`;
INSERT INTO `calendario_academico` (`id`, `programa_id`, `actividad`, `semestre`, `fecha_inicio`, `fecha_fin`) VALUES
(1,	1,	'Programación Académica',	0,	'2018-01-01 17:00:00',	'2018-01-20 17:00:00'),
(2,	1,	'Pre-Matricula de Asignaturas',	0,	'2018-01-21 17:00:00',	'2018-02-01 17:00:00'),
(3,	1,	'Cancelación Valor de la Matricula',	0,	'2018-02-02 17:00:00',	'2018-02-15 17:00:00');

DROP TABLE IF EXISTS `cargos`;
CREATE TABLE `cargos` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID Cargos',
  `descripcion` varchar(255) NOT NULL COMMENT 'Descripcion Cargos',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cargos';

TRUNCATE `cargos`;
INSERT INTO `cargos` (`id`, `descripcion`) VALUES
(1,	'Director de Unidad'),
(2,	'Convivencia'),
(3,	'Docente'),
(4,	'Psicologa');

DROP TABLE IF EXISTS `definir_asignatura`;
CREATE TABLE `definir_asignatura` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID Definir Asignatura',
  `directivos_id` int(11) NOT NULL COMMENT 'Directivos ID Definir Asignatura',
  `horario_id` int(11) NOT NULL COMMENT 'Horario ID Definir Asignatura',
  PRIMARY KEY (`id`),
  KEY `directivos_id` (`directivos_id`),
  KEY `horario_id` (`horario_id`),
  CONSTRAINT `definir_asignatura_ibfk_1` FOREIGN KEY (`directivos_id`) REFERENCES `directivos` (`id`),
  CONSTRAINT `definir_asignatura_ibfk_2` FOREIGN KEY (`horario_id`) REFERENCES `horarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Definir Asignatura';

TRUNCATE `definir_asignatura`;
INSERT INTO `definir_asignatura` (`id`, `directivos_id`, `horario_id`) VALUES
(1,	1,	3),
(2,	3,	4),
(3,	3,	2),
(4,	1,	1);

DROP TABLE IF EXISTS `directivos`;
CREATE TABLE `directivos` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID Directivos',
  `nombre1` varchar(255) NOT NULL COMMENT 'Nombre 1 Directivos',
  `nombre2` varchar(255) NOT NULL DEFAULT '' COMMENT 'Nombre 2 Directivos',
  `apellido1` varchar(255) NOT NULL COMMENT 'Apellido 1 Directivos',
  `apellido2` varchar(255) NOT NULL DEFAULT '' COMMENT 'Apellido 2 Directivos',
  `cedula` varchar(255) NOT NULL COMMENT 'Cedula Directivos',
  `telefono` varchar(255) NOT NULL DEFAULT '' COMMENT 'Telefono Directivos',
  `cargo_id` int(11) NOT NULL COMMENT 'Cargo ID Directivos',
  `correo` varchar(255) NOT NULL DEFAULT 'Sin Correo' COMMENT 'Correo Directivos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cedula` (`cedula`),
  KEY `cargo_id` (`cargo_id`),
  CONSTRAINT `directivos_ibfk_1` FOREIGN KEY (`cargo_id`) REFERENCES `cargos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Directivos';

TRUNCATE `directivos`;
INSERT INTO `directivos` (`id`, `nombre1`, `nombre2`, `apellido1`, `apellido2`, `cedula`, `telefono`, `cargo_id`, `correo`) VALUES
(1,	'Juan',	'',	'Molina',	'',	'1112788514',	'3215726683',	1,	'juan_dx1996@hotmail.com'),
(2,	'Carlos',	'',	'Perez',	'Perez',	'1234567890',	'1234567890',	3,	'docente@utp.edu.co'),
(3,	'Andres',	'David',	'Serrano',	'',	'1234567891',	'1234567890',	3,	'docente@utp.edu.co'),
(5,	'Maria',	'',	'Delgado',	'',	'1234567892',	'1234567890',	4,	'docente@utp.edu.co');

DROP TABLE IF EXISTS `directores_programa`;
CREATE TABLE `directores_programa` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID Directores Programa',
  `directivos_id` int(11) NOT NULL COMMENT 'Directivos ID Directores Programa',
  `programa_id` int(11) NOT NULL COMMENT 'Programa ID Directores Programa',
  PRIMARY KEY (`id`),
  KEY `directivos_id` (`directivos_id`),
  KEY `programa_id` (`programa_id`),
  CONSTRAINT `directores_programa_ibfk_1` FOREIGN KEY (`directivos_id`) REFERENCES `directivos` (`id`),
  CONSTRAINT `directores_programa_ibfk_2` FOREIGN KEY (`programa_id`) REFERENCES `programa` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Directores Programa';

TRUNCATE `directores_programa`;
INSERT INTO `directores_programa` (`id`, `directivos_id`, `programa_id`) VALUES
(1,	1,	1);

DROP TABLE IF EXISTS `estudiantes`;
CREATE TABLE `estudiantes` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID Estudiante',
  `nombre1` varchar(255) NOT NULL COMMENT 'Nombre 1 Estudiante',
  `nombre2` varchar(255) NOT NULL DEFAULT '' COMMENT 'Nombre 2 Estudiante',
  `apellido1` varchar(255) NOT NULL COMMENT 'Apellido 1 Estudiante',
  `apellido2` varchar(255) NOT NULL DEFAULT '' COMMENT 'Apellido 2 Estudiante',
  `cedula` varchar(255) NOT NULL COMMENT 'Cedula Estudiante',
  `telefono` varchar(255) NOT NULL DEFAULT '' COMMENT 'Telefono Estudiante',
  `tipo_id` int(11) NOT NULL COMMENT 'Tipo ID Estudiante',
  `correo` varchar(255) NOT NULL DEFAULT 'Sin Correo' COMMENT 'Correo Estudiante',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cedula` (`cedula`),
  KEY `tipo_id` (`tipo_id`),
  CONSTRAINT `estudiantes_ibfk_1` FOREIGN KEY (`tipo_id`) REFERENCES `tipo_usuario` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Estudiante';

TRUNCATE `estudiantes`;
INSERT INTO `estudiantes` (`id`, `nombre1`, `nombre2`, `apellido1`, `apellido2`, `cedula`, `telefono`, `tipo_id`, `correo`) VALUES
(1,	'Luisa',	'',	'Perilla',	'',	'1234567890',	'3193940299',	1,	'Sin Correo'),
(2,	'Carlos',	'',	'Arroyave',	'',	'1234567891',	'1234567890',	1,	'Sin Correo'),
(3,	'Andres',	'',	'Velez',	'',	'1234567892',	'1234567890',	1,	'Sin Correo'),
(4,	'Carlos',	'',	'Valencia',	'',	'1234567893',	'1234567890',	1,	'Sin Correo');

DROP TABLE IF EXISTS `forma_evaluar`;
CREATE TABLE `forma_evaluar` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID Forma Evaluar',
  `definir_id` int(11) NOT NULL COMMENT 'Definir ID Forma Evaluar',
  `corte1` int(11) NOT NULL COMMENT '% Corte 1 Forma Evaluar',
  `fecha_corte1` date NOT NULL COMMENT 'Fecha Corte 1 Forma Evaluar',
  `corte2` int(11) NOT NULL COMMENT '% Corte 2 Forma Evaluar',
  `fecha_corte2` date NOT NULL COMMENT 'Fecha Corte 2 Forma Evaluar',
  `corte3` int(11) NOT NULL COMMENT '% Corte 3 Forma Evaluar',
  `fecha_corte3` date NOT NULL COMMENT 'Fecha Corte 3 Forma Evaluar',
  PRIMARY KEY (`id`),
  KEY `definir_id` (`definir_id`),
  CONSTRAINT `forma_evaluar_ibfk_1` FOREIGN KEY (`definir_id`) REFERENCES `definir_asignatura` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Forma Evaluar';

TRUNCATE `forma_evaluar`;
INSERT INTO `forma_evaluar` (`id`, `definir_id`, `corte1`, `fecha_corte1`, `corte2`, `fecha_corte2`, `corte3`, `fecha_corte3`) VALUES
(1,	1,	35,	'2018-03-10',	35,	'2018-04-12',	30,	'2018-05-25'),
(2,	2,	35,	'2018-03-10',	35,	'2018-04-12',	30,	'2018-05-25'),
(3,	3,	35,	'2018-03-10',	35,	'2018-04-12',	30,	'2018-05-25'),
(4,	4,	35,	'2018-03-10',	35,	'2018-04-12',	30,	'2018-05-25');

DROP TABLE IF EXISTS `franjas_horarias`;
CREATE TABLE `franjas_horarias` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID Franjas Horarias',
  `franja` varchar(255) NOT NULL COMMENT 'Descripcion Franjas Horarias',
  `fecha_inicio` date NOT NULL DEFAULT '0000-00-00' COMMENT 'Fecha Inicio Franjas Horarias',
  `fecha_fin` date NOT NULL DEFAULT '0000-00-00' COMMENT 'Fecha Fin Franjas Horarias',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Franjas Horarias';

TRUNCATE `franjas_horarias`;
INSERT INTO `franjas_horarias` (`id`, `franja`, `fecha_inicio`, `fecha_fin`) VALUES
(1,	'Franja 1',	'2018-02-16',	'2018-05-25'),
(2,	'Franja 2',	'2018-02-16',	'2018-05-25');

DROP TABLE IF EXISTS `grupos`;
CREATE TABLE `grupos` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID Grupos',
  `asignatura_id` int(11) NOT NULL COMMENT 'Asignatura ID Grupos',
  `cantidad_alumnos` int(11) NOT NULL COMMENT 'Cantidad Alumnos Grupos',
  `cantidad_max` int(11) NOT NULL DEFAULT 40 COMMENT 'Cantidad Max Grupos',
  PRIMARY KEY (`id`),
  KEY `asignatura_id` (`asignatura_id`),
  CONSTRAINT `grupos_ibfk_1` FOREIGN KEY (`asignatura_id`) REFERENCES `asignaturas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Grupos';

TRUNCATE `grupos`;
INSERT INTO `grupos` (`id`, `asignatura_id`, `cantidad_alumnos`, `cantidad_max`) VALUES
(1,	2,	1,	40),
(2,	3,	0,	40),
(3,	4,	3,	40),
(4,	1,	0,	40);

DROP TABLE IF EXISTS `horarios`;
CREATE TABLE `horarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID Horario',
  `franja_id` int(11) NOT NULL COMMENT 'Franja ID Horario',
  `asignatura_id` int(11) NOT NULL COMMENT 'Asignatura ID Horario',
  `lunes` enum('Si','No') NOT NULL DEFAULT 'No' COMMENT 'Lunes Horario',
  `martes` enum('Si','No') NOT NULL DEFAULT 'No' COMMENT 'Martes Horario',
  `miercoles` enum('Si','No') NOT NULL DEFAULT 'No' COMMENT 'Miercoles Horario',
  `jueves` enum('Si','No') NOT NULL DEFAULT 'No' COMMENT 'Jueves Horario',
  `viernes` enum('Si','No') NOT NULL DEFAULT 'No' COMMENT 'Viernes Horario',
  `sabado` enum('Si','No') NOT NULL DEFAULT 'No' COMMENT 'Sabado Horario',
  `domingo` enum('Si','No') NOT NULL DEFAULT 'No' COMMENT 'Domingo Horario',
  `hora_inicio` time NOT NULL COMMENT 'Hora Inicio Horario',
  `hora_fin` time NOT NULL COMMENT 'Hora Fin Horario',
  PRIMARY KEY (`id`),
  KEY `franja_id` (`franja_id`),
  KEY `asignatura_id` (`asignatura_id`),
  CONSTRAINT `horarios_ibfk_1` FOREIGN KEY (`franja_id`) REFERENCES `franjas_horarias` (`id`),
  CONSTRAINT `horarios_ibfk_2` FOREIGN KEY (`asignatura_id`) REFERENCES `asignaturas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Horario';

TRUNCATE `horarios`;
INSERT INTO `horarios` (`id`, `franja_id`, `asignatura_id`, `lunes`, `martes`, `miercoles`, `jueves`, `viernes`, `sabado`, `domingo`, `hora_inicio`, `hora_fin`) VALUES
(1,	1,	1,	'Si',	'Si',	'Si',	'No',	'No',	'No',	'No',	'07:00:00',	'09:00:00'),
(2,	2,	1,	'Si',	'No',	'No',	'Si',	'Si',	'No',	'No',	'08:00:00',	'10:00:00'),
(3,	1,	2,	'Si',	'Si',	'Si',	'Si',	'No',	'No',	'No',	'13:00:00',	'15:00:00'),
(4,	1,	4,	'Si',	'No',	'No',	'No',	'No',	'No',	'No',	'08:00:00',	'09:00:00');

DROP TABLE IF EXISTS `portal_academico`;
CREATE TABLE `portal_academico` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID Portal Academico',
  `estado` varchar(255) NOT NULL COMMENT 'Descripcion Portal Academico',
  `activo` enum('Si','No') NOT NULL DEFAULT 'No' COMMENT 'Activo o Desactivado Portal Academico',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Portal Academico';

TRUNCATE `portal_academico`;
INSERT INTO `portal_academico` (`id`, `estado`, `activo`) VALUES
(1,	'Pre-Matricula de Asignaturas',	'No'),
(2,	'Visualización de Horarios',	'Si');

DROP TABLE IF EXISTS `programa`;
CREATE TABLE `programa` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID Programa',
  `nombre` varchar(255) NOT NULL COMMENT 'Nombre Programa',
  `cantidad_semestre` int(11) NOT NULL COMMENT 'Cantidad Semestre Programa',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Programa';

TRUNCATE `programa`;
INSERT INTO `programa` (`id`, `nombre`, `cantidad_semestre`) VALUES
(1,	'Ingenieria en Sistemas',	10),
(2,	'Ingenieria Industrial',	10),
(3,	'Ingenieria de Petroleos',	10),
(4,	'Ingenieria Civil',	10);

DROP TABLE IF EXISTS `registrar_asignaturas`;
CREATE TABLE `registrar_asignaturas` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID Registrar Asignaturas',
  `estudiante_id` int(11) NOT NULL COMMENT 'Estudiante ID Registrar Asignaturas',
  `horario_id` int(11) NOT NULL COMMENT 'Horario ID Registrar Asignaturas',
  `estado` enum('Asignado','No Asignado') NOT NULL COMMENT 'Estado Registrar Asignaturas',
  `motivo` varchar(255) NOT NULL DEFAULT 'Sin Motivo' COMMENT 'Motivo Registrar Asignaturas',
  PRIMARY KEY (`id`),
  KEY `estudiante_id` (`estudiante_id`),
  KEY `horario_id` (`horario_id`),
  CONSTRAINT `registrar_asignaturas_ibfk_1` FOREIGN KEY (`estudiante_id`) REFERENCES `estudiantes` (`id`),
  CONSTRAINT `registrar_asignaturas_ibfk_2` FOREIGN KEY (`horario_id`) REFERENCES `horarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Registrar Asignaturas';

TRUNCATE `registrar_asignaturas`;
INSERT INTO `registrar_asignaturas` (`id`, `estudiante_id`, `horario_id`, `estado`, `motivo`) VALUES
(1,	1,	3,	'Asignado',	'Sin Motivo'),
(2,	2,	4,	'Asignado',	'Sin Motivo'),
(3,	1,	4,	'Asignado',	'Sin Motivo'),
(4,	3,	4,	'Asignado',	'Sin Motivo');

DROP TABLE IF EXISTS `registro_asignaturas`;
CREATE TABLE `registro_asignaturas` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID Registro Asignaturas',
  `estudiante_id` int(11) NOT NULL COMMENT 'Estudiante ID Registro Asignaturas',
  `asignatura_id` int(11) NOT NULL COMMENT 'Asignatura ID Registro Asignaturas',
  `estado` enum('Homologado','Cursando','Aprobado','No Aprobado') NOT NULL COMMENT 'Estado Registro Asignaturas',
  PRIMARY KEY (`id`),
  KEY `estudiante_id` (`estudiante_id`),
  KEY `asignatura_id` (`asignatura_id`),
  CONSTRAINT `registro_asignaturas_ibfk_1` FOREIGN KEY (`estudiante_id`) REFERENCES `estudiantes` (`id`),
  CONSTRAINT `registro_asignaturas_ibfk_2` FOREIGN KEY (`asignatura_id`) REFERENCES `asignaturas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Registro Asignaturas';

TRUNCATE `registro_asignaturas`;
INSERT INTO `registro_asignaturas` (`id`, `estudiante_id`, `asignatura_id`, `estado`) VALUES
(1,	1,	1,	'Aprobado'),
(2,	1,	2,	'Cursando'),
(3,	2,	4,	'Cursando'),
(4,	3,	4,	'Cursando'),
(5,	1,	4,	'Cursando');

DROP TABLE IF EXISTS `registro_asistencia`;
CREATE TABLE `registro_asistencia` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID Registro Asistencia',
  `estudiante_id` int(11) NOT NULL COMMENT 'Estudiante ID Registro Asistencia',
  `horario_id` int(11) NOT NULL COMMENT 'Horario ID Registro Asistencia',
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Fecha Registro Asistencia',
  PRIMARY KEY (`id`),
  KEY `estudiante_id` (`estudiante_id`),
  KEY `horario_id` (`horario_id`),
  CONSTRAINT `registro_asistencia_ibfk_1` FOREIGN KEY (`estudiante_id`) REFERENCES `estudiantes` (`id`),
  CONSTRAINT `registro_asistencia_ibfk_2` FOREIGN KEY (`horario_id`) REFERENCES `horarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Registro Asistencia';

TRUNCATE `registro_asistencia`;
INSERT INTO `registro_asistencia` (`id`, `estudiante_id`, `horario_id`, `fecha`) VALUES
(1,	1,	3,	'2018-05-25 18:00:00'),
(2,	2,	4,	'2018-05-25 13:00:00'),
(3,	1,	4,	'2018-05-25 13:00:00'),
(4,	3,	4,	'2018-05-25 13:00:00');

DROP TABLE IF EXISTS `registro_comportamiento`;
CREATE TABLE `registro_comportamiento` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID Registro de Comportamiento',
  `estudiante_id` int(11) NOT NULL COMMENT 'Estudiante ID Registro de Comportamiento',
  `horario_id` int(11) NOT NULL COMMENT 'Horario ID Registro de Comportamiento',
  `comportamiento` enum('Excelente','Sobresaliente','Aceptable','Regular','Insuficiente') NOT NULL COMMENT 'Descripción Registro de Comportamiento',
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'Fecha Registro de Comportamiento',
  PRIMARY KEY (`id`),
  KEY `estudiante_id` (`estudiante_id`),
  KEY `horario_id` (`horario_id`),
  CONSTRAINT `registro_comportamiento_ibfk_1` FOREIGN KEY (`estudiante_id`) REFERENCES `estudiantes` (`id`),
  CONSTRAINT `registro_comportamiento_ibfk_2` FOREIGN KEY (`horario_id`) REFERENCES `horarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Registro de Comportamiento';

TRUNCATE `registro_comportamiento`;

DROP TABLE IF EXISTS `registro_notas`;
CREATE TABLE `registro_notas` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID Registro Notas',
  `horario_id` int(11) NOT NULL COMMENT 'Horario ID Registro Notas',
  `estudiante_id` int(11) NOT NULL COMMENT 'Estudiante ID Registro Notas',
  `nota_corte1` float NOT NULL COMMENT 'Nota Corte 1 Registro Notas',
  `nota_corte2` float NOT NULL COMMENT 'Nota Corte 2 Registro Notas',
  `nota_corte3` float NOT NULL COMMENT 'Nota Corte 3 Registro Notas',
  PRIMARY KEY (`id`),
  KEY `horario_id` (`horario_id`),
  KEY `estudiante_id` (`estudiante_id`),
  CONSTRAINT `registro_notas_ibfk_1` FOREIGN KEY (`horario_id`) REFERENCES `horarios` (`id`),
  CONSTRAINT `registro_notas_ibfk_2` FOREIGN KEY (`estudiante_id`) REFERENCES `estudiantes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Registro Notas';

TRUNCATE `registro_notas`;
INSERT INTO `registro_notas` (`id`, `horario_id`, `estudiante_id`, `nota_corte1`, `nota_corte2`, `nota_corte3`) VALUES
(1,	3,	1,	4.5,	4.5,	4.5),
(2,	4,	1,	5,	5,	5),
(3,	4,	2,	3.5,	3,	4),
(4,	4,	3,	2,	1.7,	4.7);

DROP TABLE IF EXISTS `tipo_usuario`;
CREATE TABLE `tipo_usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID Tipo Usuario',
  `estado` varchar(255) NOT NULL COMMENT 'Estado Tipo Usuario',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tipo Usuario';

TRUNCATE `tipo_usuario`;
INSERT INTO `tipo_usuario` (`id`, `estado`) VALUES
(1,	'Activo'),
(2,	'No Activo');

-- 2018-05-26 01:49:02
