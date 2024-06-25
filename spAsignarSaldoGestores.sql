-- =============================================
-- Author:         Roy Roger Martinez Cano
-- Fecha Creacion: 25/06/2024
-- Descripcion:    Procedimiento almacenado que recibe el numero de gestores y le asigna el saldo de parametro saldos
-- Parametros:     numeroDeGestores: el  numero de gestores a asignar el saldo, ej: 10
--                 saldos: cadena de texto con los saldos separados por coma, ej: 1225,1220,800,700,600,7000
-- =============================================
CREATE PROCEDURE spAsignarSaldoGestores
(
    @NumGestores int = 10,
    @Saldos NVARCHAR(MAX) = NULL
)
AS
BEGIN
    SET NOCOUNT ON
 -- Crear una tabla temporal para los saldos
    CREATE TABLE #Saldos (
        Saldo INT
    );

    -- Insertar los datos en la tabla temporal utilizando la función de división
    INSERT INTO #Saldos (Saldo)
    SELECT Value
    FROM dbo.funSeparaCadenaSaldo(@Saldos, ',');

    -- Crear una tabla temporal para almacenar las asignaciones de los saldos a los gestores
    CREATE TABLE #Asignaciones (
        GestorID INT,
        Saldo INT
    );

    -- Crear variables para manejar el cursor y la lógica de asignación
    DECLARE @SaldoActual INT
    DECLARE @GestorID INT = 1

    -- Crear un cursor para iterar sobre los saldos
    DECLARE SaldoCursor CURSOR FOR
    SELECT Saldo
    FROM #Saldos
    ORDER BY Saldo DESC

    OPEN SaldoCursor
    FETCH NEXT FROM SaldoCursor INTO @SaldoActual

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Insertar el saldo actual en la tabla de asignaciones con el gestor actual
        INSERT INTO #Asignaciones (GestorID, Saldo)
        VALUES (@GestorID, @SaldoActual)

        -- Incrementar el ID del gestor, y reiniciarlo si excede el número de gestores
        SET @GestorID = @GestorID + 1
        IF @GestorID > @NumGestores
        BEGIN
            SET @GestorID = 1
        END

        FETCH NEXT FROM SaldoCursor INTO @SaldoActual
    END

    CLOSE SaldoCursor
    DEALLOCATE SaldoCursor

    -- Seleccionar los datos de la tabla de asignaciones ordenados por GestorID y Saldo descendente
    SELECT GestorID, Saldo
    FROM #Asignaciones
    ORDER BY GestorID, Saldo DESC

    -- Eliminar las tablas temporales
    DROP TABLE #Saldos
    DROP TABLE #Asignaciones
END
GO