
; Base de Conocimientos.
; Practica # - ...
; Sarmiento Bryan, Zhizhpon Eduardo.

; Plantillas
(deftemplate persona
    (multislot nombre-apellido 
        (type STRING)
        (default "vacio")
    )
    (slot indice-humor-ansioso
        (type INTEGER)
        (default 0)
        (range 0 4)
    )
    (slot indice-tension
        (type INTEGER)
        (default 0)
        (range 0 4)
    )
    (slot indice-temor
        (type INTEGER)
        (default 0)
        (range 0 4)
    )
    (slot indice-insomio
        (type INTEGER)
        (default 0)
        (range 0 4)
    )
    (slot indice-funciones-intelectuales
        (type INTEGER)
        (default 0)
        (range 0 4)
    )
    (slot indice-humor-depresivo
        (type INTEGER)
        (default 0)
        (range 0 4)
    )
    (slot indice-somanticos-musculares
        (type INTEGER)
        (default 0)
        (range 0 4)
    )
    (slot indice-somanticos-sensoriales
        (type INTEGER)
        (default 0)
        (range 0 4)
    )
    (slot indice-cardiovasculares
        (type INTEGER)
        (default 0)
        (range 0 4)
    )
    (slot indice-respiratorio
        (type INTEGER)
        (default 0)
        (range 0 4)
    )
    (slot indice-gastrointestinales
        (type INTEGER)
        (default 0)
        (range 0 4)
    )
    (slot indice-genitourinarios
        (type INTEGER)
        (default 0)
        (range 0 4)
    )
    (slot indice-sistema-nervioso-autonomo
        (type INTEGER)
        (default 0)
        (range 0 4)
    )
    (slot indice-conducta-test
        (type INTEGER)
        (default 0)
        (range 0 4)
    )
)

; Funcion para sumar los sintomas.
(deffunction suma-sintomas
    (?ansioso ?tension ?temor ?insomio ?intelectual ?depresivo 
    ?musculares ?sensoriales ?cardio ?respiratorio ?gastrointestinales 
    ?genitourinarios ?nervioso ?ctest)

    (bind ?total (+ ?ansioso ?tension ?temor ?insomio
    ?intelectual ?depresivo ?musculares ?sensoriales ?cardio 
    ?respiratorio ?gastrointestinales ?genitourinarios ?nervioso ?ctest)
    )

)

; Reglas, para calcular el nivel de ansiedad.
(defrule calculo-ansiedad
    (persona 
        (nombre-apellido $?nombre)
        (indice-humor-ansioso ?ansioso)
        (indice-tension ?tension)
        (indice-temor ?temor)
        (indice-insomio ?insomio)
        (indice-funciones-intelectuales ?intelectual)
        (indice-humor-depresivo ?depresivo)
        (indice-somanticos-musculares ?musculares)
        (indice-somanticos-sensoriales ?sensoriales)
        (indice-cardiovasculares ?cardio)
        (indice-respiratorio ?respiratorio)
        (indice-gastrointestinales ?gastrointestinales)
        (indice-genitourinarios ?genitourinarios)
        (indice-sistema-nervioso-autonomo ?nervioso)
        (indice-conducta-test ?ctest)
    )
=>
    (bind ?total (suma-sintomas
                    ?ansioso ?tension ?temor ?insomio ?intelectual ?depresivo 
                    ?musculares ?sensoriales ?cardio ?respiratorio ?gastrointestinales 
                    ?genitourinarios ?nervioso ?ctest
                )
    )

    (if (= ?total 0)
    then
        (assert (ansiedad-nula $?nombre ?total))
        (printout t ?total " | Ansiedad Nula " crlf)
    )
    
    (if (and
			(> ?total 0)
			(< ?total 17)
		)
    then
        (assert (ansiedad-leve $?nombre ?total))
        (printout t ?total " | Ansiedad Leve " crlf)
    )

    (if (and
            (>= ?total 18)
            (<= ?total 24)
        )
    then
        (assert (ansiedad-moderada $?nombre ?total))
        (printout t ?total " | Ansiedad Moderado " crlf)
    )
    
    (if (>= ?total 24)
    then
        (assert (ansiedad-severa $?nombre ?total))
        (printout t ?total " | Ansiedad Severa " crlf)
    )

    (save-facts "clips/facts_data.dat")
)
