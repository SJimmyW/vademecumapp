# Dockerfile for Veterinary Knowledge Suite (Shiny app)
# Built from rocker/shiny base image (R 4.6.1)

FROM rocker/shiny:4.6.1

# Install system libraries commonly required by R packages used in this app
RUN apt-get update && apt-get install -y --no-install-recommends \
    libcurl4-openssl-dev \
    libxml2-dev \
    libssl-dev \
    libgit2-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libpng-dev \
    libjpeg-dev \
    libuv1 \
    pkg-config \
    
    && rm -rf /var/lib/apt/lists/*

# Create app directory
WORKDIR /srv/shiny-server/app

# Copy app files into the image
COPY . /srv/shiny-server/app

# Install R packages required by the app
# Keep this list in sync with packages.R / manifest.json
RUN R -e "install.packages(c('shiny','bslib','shinyWidgets','readxl','dplyr','stringr','purrr','tidyr','DT','htmltools'), repos='https://cloud.r-project.org')"

# Ensure logs directory exists (logger writes logs/app.log)
RUN mkdir -p /srv/shiny-server/app/logs && chown -R shiny:shiny /srv/shiny-server/app

# Expose Shiny port
EXPOSE 3838

# Run shiny-server (image's default entrypoint runs shiny-server)
#CMD ["/usr/bin/shiny-server", "--no-daemon"]
CMD ["R", "-e", "options(shiny.host='0.0.0.0'); shiny::runApp('/srv/shiny-server/app', port = as.integer(Sys.getenv('PORT', '3838')), launch.browser = FALSE)"]
