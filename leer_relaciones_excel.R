##############################################################################
###' File: leer_relaciones_excel.R
###'
###' Purpose: Read the "Relaciones" sheet from a local Excel workbook and
###' return a cleaned data.frame usable by resolver_destinos() and presentation
###' modules. Provides sensible defaults when the sheet is missing or columns
###' are absent.
###'
###' Author: generated
###' Date: 2026-07-18
##############################################################################

leer_relaciones_excel <- function(file){
  if(missing(file) || !file.exists(file)){
    warning("leer_relaciones_excel: file not provided or does not exist: ", file)
    # return empty tibble with expected columns
    cols <- c("origen_app","origen_id","destino_app","destino_id",
              "tipo_relacion","rol","especie","observaciones","titulo_destino")
    return(as.data.frame(setNames(replicate(length(cols), character(0), simplify = FALSE), cols), stringsAsFactors = FALSE))
  }

  # ensure readxl is available
  if(!requireNamespace("readxl", quietly = TRUE))
    stop("Package 'readxl' is required to read Excel files.")

  sheets <- tryCatch(readxl::excel_sheets(file), error = function(e) NULL)
  if(is.null(sheets) || !"Relaciones" %in% sheets){
    message("leer_relaciones_excel: sheet 'Relaciones' not found in ", file)
    cols <- c("origen_app","origen_id","destino_app","destino_id",
              "tipo_relacion","rol","especie","observaciones","titulo_destino")
    return(as.data.frame(setNames(replicate(length(cols), character(0), simplify = FALSE), cols), stringsAsFactors = FALSE))
  }

  # read everything as text to avoid type surprises
  raw <- readxl::read_excel(file, sheet = "Relaciones", col_types = "text")

  # normalize: trim whitespace and collapse multiple internal spaces
  if(nrow(raw) > 0){
    raw <- as.data.frame(lapply(raw, function(col){
      if(is.character(col)){
        # str_squish equivalent without adding dependency if stringr absent
        s <- gsub("\\s+", " ", col)
        s <- trimws(s)
        s
      } else {
        as.character(col)
      }
    }), stringsAsFactors = FALSE)
  }

  # ensure required columns exist (create as NA_character_ if missing)
  required <- c("origen_app","origen_id","destino_app","destino_id")
  optional  <- c("tipo_relacion","rol","especie","observaciones","titulo_destino")
  for(col in c(required, optional)){
    if(!col %in% names(raw))
      raw[[col]] <- NA_character_
  }

  # reorder to predictable layout
  cols_final <- c(required, optional, setdiff(names(raw), c(required, optional)))
  resultado <- raw[ , cols_final, drop = FALSE]

  # make sure columns are character
  resultado <- as.data.frame(lapply(resultado, as.character), stringsAsFactors = FALSE)

  return(resultado)
}
