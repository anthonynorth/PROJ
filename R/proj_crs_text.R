#' Generate a projection string.
#'
#' Input any accepted format of 'PROJ' coordinate reference system specification.
#' Return value is a string in the requested format.
#'
#' This function requires PROJ version 6.0 or higher to be useful. If not, this
#' function simply returns 'NA'.
#'
#' See the [library documentation](https://proj.org/development/reference/functions.html#transformation-setup)
#' for details on input and output formats.
#'
#' Some nuances of the format are not available, currently we use formats
#' '0: PJ_WKT2_2018' '1: PJ_PROJ_5', '2: PROJJSON'.
#'
#' Some formats are hard to read, such as WKT so for easy reading
#' use `cat()`.
#' @export
#' @param format integer, 0 for 'WKT', 1 for 'PROJ'
#' @param source input projection specification one of ('PROJ4', 'WKT2',
#'  'EPSG', 'PROJJSON', ... see the library documentation link in Details)
#'
#' @return character string in requested format
#'
#' @examples
#' cat(proj_crs_text("EPSG:4326", format = 0L))
#' proj_crs_text("EPSG:4326", format = 1L)
#' south55 <- "+proj=utm +zone=55 +south +ellps=GRS80 +units=m +no_defs +type=crs"
#' proj_crs_text(proj_crs_text(south55), 1L)
proj_crs_text <- function(source, format = 0L) {
  stopifnot(length(format) == 1L)
  stopifnot(format %in% c(0L, 1L, 2L))
  stopifnot(is.character(source))
  stopifnot(length(source) == 1L)
  .Call("C_proj_crs_text",
        crs_ = source,
        format = as.integer(format),
        PACKAGE = "PROJ")
}