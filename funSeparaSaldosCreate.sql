-- =============================================
-- Author:         Roy Roger Martinez Cano
-- Fecha Creacion: 25/06/2024
-- Descripcion:    funcion que recibe una cadena de saldos separadas por coma y devuelve una tabla
--                 de los valores de los saldos separados, como auxiliar al procedimiento almacenado spAsignarSaldoGestores
-- Parametros:     cadenaSaldos: es la cadena de saldos a separar, ej: 1225,1220,800,700,600,7000
--                 delimitador: es el caracter por el cual se va a separar la cadena en este caso seria ideal dejar por ','
-- =============================================
CREATE FUNCTION dbo.funSeparaCadenaSaldo
(
    @cadenaSaldos NVARCHAR(MAX),
    @delimitador CHAR(1) = ','
)
RETURNS @tablaSalida TABLE (Value INT)
AS
BEGIN
    DECLARE @indiceInicio INT, @IndiceFinal INT

    SET @indiceInicio = 1
    IF SUBSTRING(@cadenaSaldos, LEN(@cadenaSaldos) - 1, LEN(@cadenaSaldos)) <> @delimitador
    BEGIN
        SET @cadenaSaldos = @cadenaSaldos + @delimitador
    END

    WHILE CHARINDEX(@delimitador, @cadenaSaldos, @indiceInicio) > 0
    BEGIN
        SET @IndiceFinal = CHARINDEX(@delimitador, @cadenaSaldos, @indiceInicio)
        INSERT INTO @tablaSalida(Value) 
        VALUES(CAST(SUBSTRING(@cadenaSaldos, @indiceInicio, @IndiceFinal - @indiceInicio) AS INT))
        SET @indiceInicio = @IndiceFinal + 1
    END

    RETURN
END
GO
