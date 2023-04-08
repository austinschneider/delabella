cmake_minimum_required(VERSION 2.6)
cmake_policy(SET CMP0048 "NEW")

project(delabella LANGUAGES CXX VERSION 1.0)

add_library(delabella OBJECT ${PROJECT_SOURCE_DIR}/delabella.cpp)

# shared libraries need PIC
set_property(TARGET delabella PROPERTY POSITION_INDEPENDENT_CODE ON)

# shared and static libraries built from the same object files
add_library(delabella_shared SHARED $<TARGET_OBJECTS:delabella>)
add_library(delabella_static STATIC $<TARGET_OBJECTS:delabella>)
set_target_properties(delabella_shared PROPERTIES OUTPUT_NAME delabella POSITION_INDEPENDENT_CODE ON)
set_target_properties(delabella_static PROPERTIES OUTPUT_NAME delabella POSITION_INDEPENDENT_CODE ON)

target_include_directories(${PROJECT_NAME} PUBLIC ${PROJECT_SOURCE_DIR})

#add_library(delabella::delabella ALIAS delabella)

install(FILES ${PROJECT_SOURCE_DIR}/delabella.h DESTINATION include)
install(TARGETS ${PROJECT_NAME} ARCHIVE DESTINATION lib)
