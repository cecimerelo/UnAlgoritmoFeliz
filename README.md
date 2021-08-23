# Trabajo de Fin de Grado: *Un Algoritmo feliz*

### Autor(a): Cecilia Merelo Molina
### Tutor(a)(es): Juan Julián Merelo Guervós

# EJECUCIÓN

Para ejecutar un caso base del algoritmo:

```bash
make base_example
```

Para correr todos los tests:

```bash
make tests
```
___
# DOCUMENTACIÓN 
La documentación de este proyecto está realizada con `LaTeX`, por lo
tanto para generar el archivo PDF necesitaremos instalar `TeXLive` en
nuestra distribución.

Una vez instalada, tan solo deberemos situarnos en el directorio `doc` y ejecutar:

`
$ pdflatex proyecto.tex
`

Seguido por

    bibtex proyecto
    
y de nuevo

    pdflatex proyecto.tex

O directamente

    make
    
(que habrá que editar si el nombre del archivo del proyecto cambia)

# INSTRUCCIONES

Lee [INSTALL.md](INSTALL.md) para las instrucciones de uso.
