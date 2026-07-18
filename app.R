

### │
## ├── app.R                  ← main
###  │
###´ ├── global.R               ← Parte 1
###´ │
###´ ├── ui.R                   ← Parte 2
###´ │
###´ ├── server.R               ← Parte 3
###´ │
###´ ├── data/
###´ │      info.xlsx
###´ │
###´ ├── R/
###´   │
###´  │   ├── utilities/
###´ │   │      titulo.R
###´ │   │      componentes.R
###´  │   │      columnas_estructura.R
###´ │   │      columnas_paneles.R
###´ │   │      primer_texto.R
###´ │   │      texto_lista.R
###´ │   │      valores_disponibles.R
###´ │   │      opciones_busqueda.R
###´ │   │      obtener_registro.R
###´ │   │
###´ │   ├── navigation/
  ###´   │   │      actualizar_picker.R
###´ │   │      buscar_registros.R
###´ │   │      resolver_registro.R
###´ │   │
###´ │   └── presentation/
  ###´   │          contenido_panel.R
###´ │          construir_encabezado.R
###´ │          construir_accordion.R
###´ │          construir_recursos.R
###´ │
###´ ├── README.md
###´ │
###´ ├── LICENSE
###´ │
###´ └── .gitignor

##############################################################################
###' File: app.R
###'
###' Purpose: Application entry point.
###'
###' Description: Loads the global configuration, user interface and
###'   server components, then launches the Shiny application.
###'
###' Author: SJWatson
###' AI Collaboration: Developed with assistance from OpenAI ChatGPT (GPT-5.5).
###' Date:2026
##############################################################################
#stop("ESTE ES MI APP.R")
cat("===== APP =====\n")

  source("parte_1.R")  # source("global.R")
cat("===== PARTE 1 CARGADA =====\n")
  
  source("ui.R")      # source("parte_2.R") 
cat("===== ui CARGADA =====\n")

  source("server.R") # source("parte_3.R") # 
cat("===== server CARGADo =====\n")

  shinyApp( ui = ui,server = server   )

  # 
  
