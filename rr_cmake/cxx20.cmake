set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
if (MSVC)
add_compile_options(/Zc:preprocessor /MP)
endif ()

