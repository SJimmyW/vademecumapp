##############################################################################
### Simple logger utility for local testing and lightweight deployment.
### Writes messages to logs/app.log and prints level-prefixed messages to console.
###
### Usage:
###   log_info("starting app")
###   log_warn("something odd")
###   log_error("fatal")
##############################################################################

log_msg <- function(level, ..., .file = file.path(getwd(), "logs", "app.log")){
  try({
    dir <- dirname(.file)
    if(!dir.exists(dir)) dir.create(dir, recursive = TRUE, showWarnings = FALSE)
    ts <- format(Sys.time(), "%Y-%m-%d %H:%M:%S")
    text <- paste(..., collapse = " ")
    line <- sprintf("[%s] %-5s %s\n", ts, toupper(level), text)
    cat(line, file = .file, append = TRUE)
    # also print to console
    cat(line)
  }, silent = TRUE)
}

log_info <- function(...){ log_msg("info", ...) }
log_warn <- function(...){ log_msg("warn", ...) }
log_error <- function(...){ log_msg("error", ...) }

# Example: set option to point to custom logfile
# options(vademecum.logfile = "/path/to/log")

