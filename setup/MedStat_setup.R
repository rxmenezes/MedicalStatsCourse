if( !exists( "params" ) ){
  params <- list(
    "RCourseGitURL" = "https://github.com/rxmenezes/RcourseNKI",
    "RCourseURL" = "https://github.com/rxmenezes/RcourseNKI"
  )
}

catReadTable <- function( fileName, varName ) {
  cat( paste0( "# To get '", fileName, "' directly from the server, use:\n" ) );
  cat( paste0(
    '# ',
    varName, ' <- ',
    'read.table( url( "',
    params$RCourseURL,
    '/tree/master/data/',
    fileName,
    '" ), header = TRUE, sep = "\\t" )\n'
  ) );

  invisible( read.table( paste0( "data/", fileName ), header = TRUE, sep = "\t" ) );
}

catReadLines <- function( fileName, varName ) {
  cat( paste0( "# To get '", fileName, "' directly from the server, use:\n" ) );
  cat( paste0(
    '# ',
    varName, ' <- ',
    'readLines( url( "',
    params$RCourseURL,
    '/tree/master/data/',
    fileName,
    '" ) )\n'
  ) );

  invisible( readLines( paste0( "../data/", fileName ) ) );
}

catReadDelim <- function( fileName, varName = NULL ) {
  cat( paste0( "# To get '", fileName, "' directly from the server, use:\n" ) );
  cat( '# ' );
  if( !is.null( varName ) ) {
    cat( paste0( varName, " <- " ) );
  }
  cat( paste0(
    'read.delim( url( "',
    params$RCourseURL,
    '/tree/master/data/',
    fileName,
    '" ) )\n'
  ) )
}

catReadCsv <- function( fileName, varName = NULL, args = c() ) {
  cat( paste0( "# To get '", fileName, "' directly from the server, use:\n" ) );
  cat( '# ' );
  if( !is.null( varName ) ) {
    cat( paste0( varName, " <- " ) );
  }
  cat( paste0(
    'read.csv( url( "',
    params$RCourseURL,
    '/tree/master/data/',
    fileName,
    '" )'
  ) );
  if( length( args ) > 0 ) {
    cat( ', ' );
    cat( paste( args, sep = ", " ) );
  }
  cat(
    ' )\n'
  );

  invisible( read.csv( paste0( "data/", fileName ) ) );
}

catLoad <- function( fileName ) {
  cat( paste0( "# To get '", fileName, "' directly from the server, use:\n" ) );
  cat( '# ' );
  cat( paste0(
    'load( url( "',
    params$RCourseURL,
    '/tree/master/data/',
    fileName,
    '" ) )\n'
  ) )
}

catLinkTaskSection <- function( mainDoc ) {
  code <- paste0( gsub( "[.]Rmd$", ".tasks.code.html", mainDoc ));
  nocode <- paste0( gsub( "[.]Rmd$", ".tasks.nocode.html", mainDoc ));

  cat( "\n- - -\n\n" );
  cat( "> _Quick task(s)_:\n> \n" );
  cat( paste0(
    "> Solve [the task(s)](",
    nocode,
    "), and check your solution(s) [here](",
    code,
    ").\n\n"
  ) );
  cat( "- - -\n\n" );
}

catTopic <- function( l, dir = "", msg = "", targetExt = "html" ) {
  f <- paste0( dir, "/", l$file, ".Rmd" );
  stopifnot( file.exists( f ) );

  f <- paste0( dir, "/", l$file, ".", targetExt );
  msg( "    - [", l$title, "](", f, ")" );

  f <- paste0( dir, "/", l$file, ".tasks.Rmd" );
  if( file.exists( f ) ) {
    f <- paste0( dir, "/", l$file, ".tasks.nocode.", targetExt );
    msg( " [[tasks](", f, ")]" );
    f <- paste0( dir, "/", l$file, ".tasks.code.", targetExt );
    msg( " [[solutions](", f, ")]" );
  }
  msg( "\n" );
}

catSlot <- function( l,
  msg = function( ... ) { cat( paste0( ..., sep = "" ) ) },
  targetExt = "html"
) {
  msg( "- Slot ", l$slot )
  if( !is.null( l$title ) ) {
    msg( ", ", l$title );
  }
  msg( ":\n" );

  for( topic in l$topics ) {
    catTopic( topic, dir = l$dir, msg = msg, targetExt = targetExt );
  }
}
