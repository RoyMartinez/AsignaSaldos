# AsignaSaldos
Este repositorio tiene el algoritmo para desde TSql recibir una lista de saldos y asignarlos a cierto numero de gestores

## Paso para reproducir
desde Sql server por favor crear una base de datos
```
create database dbAsignarSaldo
```
Luego ejecutar en el siguiente orden los scripts
1. funSeparaSaldosCreate
2. spAsignarSaldosGestores
3. Ejecucion
## descripcion de cada script
**funSeparaSaldosCreate:** Contiene el codigo para crear una funcion que recibe una cadena de saldos separadas por coma y sin punto al final esto para quitar logica que pueda resulta un tanto fuera de la ejecucion del procedimiento almacenado principal.

**spAsignarSaldosGestores:** Contiene el codigo para crear el procedimiento almacenado que realiza la ejecucion del algoritmo este llama a la funcion funseparaSaldos por eso este debe ir despues de la creacion de la misma.

**Ejecucion:** es la ejecucion del procedimiento almacenado.

### Notas
la cadena de saldos porfavor sin punto al final de la misma
