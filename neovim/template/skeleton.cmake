CMAKE_MINIMUM_REQUIRED(VERSION 3.5 FATAL_ERROR)
PROJECT(xxx)

IF(CMAKE_HOST_UNIX)
  IF(NOT DEFINED ANDROID_ABI)
    SET(HOST_OS unix)
  ELSE()
    SET(HOST_OS android/${ANDROID_ABI})
  ENDIF()
ELSEIF(CMAKE_HOST_WIN32)
  IF(CMAKE_CL_64)
    SET(HOST_OS win/x64)
  ELSE()
    SET(HOST_OS win/x86)
  ENDIF()
ENDIF()

# ADD_COMPILE_OPTIONS("$<$<C_COMPILER_ID:MSVC>:/utf-8>")
# ADD_COMPILE_OPTIONs("$<$<CXX_COMPILER_ID:MSVC>:/utf-8>")

SET(CMAKE_CXX_STANDARD 11)
SET(CMAKE_BUILD_TYPE Release)

SET(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib)
SET(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib)
SET(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)

FIND_PACKAGE(xxx REQUIRED)

INCLUDE_DIRECTORIES(
  include
)

ADD_LIBRARY(xxx SHARED)

ADD_EXECUTABLE(xxx)

TARGET_LINK_LIBRARIES(xxx xxx)