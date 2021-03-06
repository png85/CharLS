#
# CMakeLists.txt for CharLS JPEG-LS library
#
project(CharLS)
cmake_minimum_required(VERSION 2.6)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake-modules")

option(CharLS_BUILD_AS_SUBMODULE "Build CharLS as git submodule?" OFF)
option(CharLS_BUILD_SHARED_LIB "Build CharLS as shared library?" ON)
option(CharLS_BUILD_TESTS "Build test binaries for CharLS?" ON)


#
# Version info
set(CharLS_VERSION_MAJOR 1)
set(CharLS_VERSION_MINOR 0)
set(CharLS_VERSION_PATCH 3)

#
# Enable C++11 for GCC builds
if(CMAKE_COMPILER_IS_GNUCXX)
    include(CheckCXXCompilerFlag)
    check_cxx_compiler_flag("-std=c++11" GCC_stdcxx11)
    check_cxx_compiler_flag("-std=c++0x" GCC_stdcxx0x)

    if(GCC_stdcxx11)
        # Compiler supports -std=c++11
        message(STATUS "Using -std=c++11 to enable C++11 in GCC")
        add_definitions(-std=c++11)
    elseif(GCC_stdcxx0x)
        # Compiler doesn't support -std=c++11 but -std=c++0x
        message(STATUS "Using -std=c++0x to enable C++11 in GCC")
        add_definitions(-std=c++0x)
    else()
        # Neither -std=c++11 nor -std=c++0x are supported
        message(WARNING "Failed to determine C++11 flag for GCC :-(")
    endif()
endif(CMAKE_COMPILER_IS_GNUCXX)

include(CheckCXX11Features)
foreach(flag ${CXX11_FEATURE_LIST})
  add_definitions(-D${flag})
endforeach()


if(NOT CharLS_BUILD_AS_SUBMODULE)
    set(CPACK_PACKAGE_DESCRIPTION "CharLS JPEG-LS library")
    set(CPACK_PACKAGE_VENDOR "#das-system Networks GbR")
    set(CPACK_PACKAGE_VERSION_MAJOR "${CharLS_VERSION_MAJOR}")
    set(CPACK_PACKAGE_VERSION_MINOR "${CharLS_VERSION_MINOR}")
    set(CPACK_PACKAGE_VERSION_PATCH "${CharLS_VERSION_PATCH}")
    if(WIN32)
        set(CPACK_GENERATOR "ZIP")
        set(CPACK_SOURCE_GENERATOR "ZIP")
    else(WIN32)
        set(CPACK_GENERATOR "TGZ;TBZ2")
        set(CPACK_SOURCE_GENERATOR "TGZ;TBZ2")
    endif(WIN32)
    include(CPack)
endif(NOT CharLS_BUILD_AS_SUBMODULE)


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

if(CharLS_BUILD_TESTS)
    include(CTest)
    file(GLOB CharLS_TEST_SRCS test/*.cpp)
    add_executable(CharLS-test ${CharLS_TEST_SRCS})
    target_link_libraries(CharLS-test CharLS)
    add_test(unittest ${CMAKE_COMMAND} -E chdir ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR}/CharLS-test "-dontwait" "-unittest")
    add_test(bitstreamdamage ${CMAKE_COMMAND} -E chdir ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR}/CharLS-test "-dontwait" "-bitstreamdamage")
    add_test(performance "${CMAKE_COMMAND}" -E chdir ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR}/CharLS-test "-dontwait" "-performance")
endif(CharLS_BUILD_TESTS)
