-- =============================================
-- Author:         Roy Roger Martinez Cano
-- Fecha Creacion: 25/06/2024
-- Descripcion:    Ejecucion de prueba del procedimiento almacenado
-- Parametros:     numeroDeGestores: el  numero de gestores a asignar el saldo, ej: 10
--                 saldos: cadena de texto con los saldos separados por coma, ej: 1225,1220,800,700,600,7000
-- =============================================
EXEC spAsignarSaldoGestores 
    @Saldos = '2277, 3953, 4726, 1414, 627, 1784, 1634, 3958, 2156, 1347, 2166, 820, 2325, 3613, 2389, 4130, 2007, 3027, 2591, 3940, 3888, 2975, 4470, 2291, 3393, 3588, 3286, 2293, 4353, 3315, 4900, 794, 4424, 4505, 2643, 2217, 4193, 2893, 4120, 3352, 2355, 3219, 3064, 4893, 272, 1299, 4725, 1900, 4927, 4011', 
    @NumGestores = 10;