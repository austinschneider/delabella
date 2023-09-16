cmake_minimum_required(VERSION 2.6)
cmake_policy(SET CMP0048 "NEW")

project(delabella LANGUAGES CXX VERSION 1.0)


set(DELABELLA_BUILD_SHARED ON CACHE BOOL "Build shared object library")
set(DELABELLA_BUILD_STATIC OFF CACHE BOOL "Build static library")

add_library(delabella OBJECT ${PROJECT_SOURCE_DIR}/delabella.cpp)

# shared libraries need PIC
set_property(TARGET delabella PROPERTY POSITION_INDEPENDENT_CODE ON)

# shared and static libraries built from the same object files
if(DELABELLA_BUILD_SHARED)
    add_library(delabella_shared SHARED $<TARGET_OBJECTS:delabella>)
    set_target_properties(delabella_shared PROPERTIES OUTPUT_NAME delabella POSITION_INDEPENDENT_CODE ON)
    set_target_properties(delabella_shared PROPERTIES EXPORT_NAME delabella)
    target_include_directories(delabella_shared PUBLIC
        $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}>
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
    )
    install(TARGETS delabella_shared
        EXPORT ${PROJECT_NAME}Config
        ARCHIVE DESTINATION lib)
endif()

if(DELABELLA_STATIC)
    add_library(delabella_static STATIC $<TARGET_OBJECTS:delabella>)
    set_target_properties(delabella_static PROPERTIES OUTPUT_NAME delabella POSITION_INDEPENDENT_CODE ON)
    set_target_properties(delabella_static PROPERTIES EXPORT_NAME delabella)
    target_include_directories(delabella_static PUBLIC
        $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}>
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
    )
    install(TARGETS delabella_static
        EXPORT ${PROJECT_NAME}Config
        ARCHIVE DESTINATION lib)
endif()

install(FILES ${PROJECT_SOURCE_DIR}/delabella.h
    DESTINATION include)

# Export targets for use in downstream CMake projects
# -----------------------------------------------------------------------------
include(CMakePackageConfigHelpers)
# Make importable from build directory
write_basic_package_version_file(
  "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
  VERSION ${PROJECT_VERSION}
  COMPATIBILITY AnyNewerVersion
)
export(EXPORT ${PROJECT_NAME}Config FILE ${PROJECT_NAME}Config.cmake)

# Make importable from install location
set(_config_dir share/${PROJECT_NAME}/cmake)
install(FILES "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
  DESTINATION ${_config_dir}
)
install(EXPORT ${PROJECT_NAME}Config
  DESTINATION ${_config_dir}
)

