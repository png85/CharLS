#
# Copyright (c) 2013 P. Hille <peter@das-system-networks.de>
#
# Redistribution and use is allowed according to the terms of the new
# BSD license.
#
# This CMake script can be used to search for the CharLS JPEG-LS library
# via a find_package() call. It defines the following variables:
#
# CharLS_FOUND       - Indicates wether the library has been found at all
# CharLS_LIBRARY     - Name of the library to link
# CharLS_INCLUDE_DIR - Path to the header files to include
#
# The script searches common locations on UNIX and can be forced to make use
# of a known location via the 'CharLS' environment variable which is supposed
# to point to the root of the installed SDK. If the variable is set, the script
# searches the 'include' and 'lib' subdirectories for header files and libraries.
#

find_path(CharLS_INCLUDE_DIR CharLS/interface.h
  "$ENV{CharLS}/include"
  /usr/local/include
  /usr/include
)

find_library(CharLS_LIBRARY
  NAMES CharLS
  PATHS "$ENV{CharLS}/lib" /usr/lib /usr/local/lib
)

if (CharLS_LIBRARY AND CharLS_INCLUDE_DIR)
  set(CharLS_LIBRARIES ${CharLS_LIBRARY})
  set(CharLS_INCLUDE_DIRS ${CharLS_INCLUDE_DIR})
  set(CharLS_FOUND "YES")
else ()
  set(CharLS_FOUND "NO")
endif ()

if (CharLS_FOUND)
  if(NOT CharLS_FIND_QUIETLY)
    message(STATUS "Found CharLS: ${CharLS_LIBRARY}")
  endif()
else()
  if(CharLS_FIND_REQUIRED)
    message(FATAL_ERROR "Couldn't find CharLS libary!")
  endif()
endif()

mark_as_advanced(
  CharLS_LIBRARY
  CharLS_INCLUDE_DIR
)
