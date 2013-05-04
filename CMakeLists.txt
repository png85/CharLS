#
# CMakeLists.txt for CharLS JPEG-LS library
#
project(CharLS)
cmake_minimum_required(VERSION 2.6)

option(CharLS_BUILD_SHARED_LIB "Build CharLS as shared library" ON)


#
# Version info
set(CharLS_VERSION_MAJOR 1)
set(CharLS_VERSION_MINOR 0)
set(CharLS_VERSION_PATCH 1)


set(CPACK_PACKAGE_DESCRIPTION "CharLS JPEG-LS library")
set(CPACK_PACKAGE_VENDOR "#das-system Networks GbR")
set(CPACK_PACKAGE_VERSION_MAJOR "${CharLS_VERSION_MAJOR}")
set(CPACK_PACKAGE_VERSION_MINOR "${CharLS_VERSION_MINOR}")
set(CPACK_PACKAGE_VERSION_PATCH "${CharLS_VERSION_PATCH}")
set(CPACK_GENERATOR "TGZ;TBZ2;ZIP")
set(CPACK_SOURCE_GENERATOR "TGZ;TBZ2;ZIP")
include(CPack)


#
# List of source/header files
set(CharLS_SRCS header.cpp interface.cpp jpegls.cpp)
set(CharLS_HDRS colortransform.h context.h decoderstrategy.h encoderstrategy.h interface.h
                losslesstraits.h scan.h streams.h config.h contextrunmode.h defaulttraits.h
                header.h lookuptable.h processline.h util.h publictypes.h)

#
# Actual library build target
if(CharLS_BUILD_SHARED_LIB)
  if(WIN32)
    # Add -DCHARLS_DLL for proper symbol export from the DLL's accompanying stub library
    add_definitions(-DCHARLS_DLL)
  endif(WIN32)
  add_library(CharLS SHARED ${CharLS_SRCS} ${CharLS_HDRS})
  if(UNIX)
    # Set library version info for UNIX
    set_target_properties(CharLS PROPERTIES VERSION ${CharLS_VERSION_MAJOR}.${CharLS_VERSION_MINOR}
                                            SOVERSION ${CharLS_VERSION_MAJOR})
  endif(UNIX)
  install(TARGETS CharLS LIBRARY DESTINATION lib
                         ARCHIVE DESTINATION lib
                         RUNTIME DESTINATION bin)
else(CharLS_BUILD_SHARED_LIB)
  if(WIN32)
    # Add -DCHARLS_STATIC for proper symbol export from the static lib
    add_definitions(-DCHARLS_STATIC)
  endif(WIN32)
  add_library(CharLS STATIC ${CharLS_SRCS} ${CharLS_HDRS})
  install(TARGETS CharLS ARCHIVE DESTINATION lib)
endif(CharLS_BUILD_SHARED_LIB)

#
# Install rule for headers
install(FILES ${CharLS_HDRS} DESTINATION include/CharLS)

include(CTest)
if(BUILD_TESTING)
  add_executable(CharLS-test test/main.cpp test/time.cpp test/util.cpp test/bitstreamdamage.cpp
                             test/compliance.cpp test/performance.cpp test/dicomsamples.cpp)
  target_link_libraries(CharLS-test CharLS)
endif(BUILD_TESTING)
