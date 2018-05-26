SELECT CONCAT(apellido1, ' ',apellido2, ' ',nombre1, ' ', nombre2) AS Estudiante, nombre AS Asignatura, estado AS 'Estado Actual' FROM registro_asignaturas r INNER JOIN asignaturas a ON a.id = r.asignatura_id INNER JOIN estudiantes e ON e.id = r.estudiante_id ORDER BY estado, apellido1, apellido2, nombre1, nombre2