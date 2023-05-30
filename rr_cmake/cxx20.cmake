set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_compile_options($<$<CXX_COMPILER_ID:MSVC>:/MP>)
add_compile_options($<$<CXX_COMPILER_ID:MSVC>:/Zc:preprocessor>)
add_compile_options($<$<CXX_COMPILER_ID:MSVC>:/wd5105>)


if (WIN32)
add_definitions(-DNOMINMAX)
add_definitions(-DWIN32_LEAN_AND_MEAN)
endif ()

